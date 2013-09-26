class ChatForm
  include ActiveModel::Model
  include Virtus

  attr_reader :chat

  attribute :message, String
  attribute :subject, String
  attribute :user, User
  attribute :user_ids, String

  validates :message, :user_ids, :user, presence: true
  validates :message, length: {maximum: 2000}
  validates :subject, length: {maximum: 200}
  validate :ensure_recipients_do_not_contain_creator

  def persisted?
    self.chat.try(:persisted?)
  end

  def save
    if valid?
      persist!
      true
    else
      false
    end
  end

  # Public: Returns Array of User of the recipients.
  def recipients
    @recipients ||= User.where(id: self.user_ids.split(/,/))
  end

private

  def persist!
    existing_chats = Chat.between(recipients, self.user).includes(:chat_participations)
    # Ensures all Users in the existing Chat are the same, no more and no less.
    @chat = existing_chats.detect { |mt| mt.chat_participations.size == recipients.size + 1}
    unless @chat
      @chat = Chat.new(user: self.user, subject: self.subject)
      self.recipients.each {|u| @chat.chat_participations.build(user: u, chat: @chat)}
    end
    message = @chat.messages.new(content: self.message, user: self.user)

    if @chat.new_record?
      @chat.save!
    else
      @chat.save!
      message.save!
    end
  end

  def ensure_recipients_do_not_contain_creator
    errors.add(:user_ids) if self.recipients.include?(self.user)
  end

end
