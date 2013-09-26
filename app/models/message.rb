class Message < ActiveRecord::Base
  attr_accessor :skip_notifications

  belongs_to :chat, touch: true
  belongs_to :user

  validates :content, presence: true, length: {within: 1..2000}
  after_create :join_user_to_chat
  after_create :unarchive_chat
  after_commit :reset_users_cache, on: :create
  # after_commit :send_notifications, on: :create

  auto_strip_attributes :content

  class << self
    # Public: Finds recent Messages. Plesae note the result is sorted reverse chronologically.
    #
    # options - Hash for the find options.
    #                 prior_to_id: Messages returned will have ID less then prior_to_id (optional).
    #                 since_id: Messages returned will have ID greater than since_id (optional).
    #
    # Returns ActiveRecord::Relation.
    #
    def recent(options={})
      results = self.reorder("messages.id DESC")
      results = results.where(["messages.id < :message_id", {message_id: options[:prior_to_id]}]) if options[:prior_to_id].present?
      results = results.where(["messages.id > :message_id", {message_id: options[:since_id]}]) if options[:since_id].present?
      results
    end
  end

  # Public: Delivers notifications to Chat Users.
  def notify!
    chat = self.chat
    chat.users.each do |u|
      unless u == self.user
        I18n.with_locale(u.locale) do
          NotificationMailer.delay.message_mail(self.id, u.id) if u.send_message_email
        end
      end
    end
  end

private

  def join_user_to_chat
    self.chat.join!(self.user)
  end

  def unarchive_chat
    ChatParticipation.where(chat_id: self.chat_id).where("archived_at IS NOT NULL").update_all(archived_at: nil)
  end

  def reset_users_cache
    ChatCacheSweeper.perform_async(self.chat_id)
  end

  def send_notifications
    MessageNotifier.perform_async(self.id) unless self.skip_notifications
  end
end
