class Chat < ActiveRecord::Base
  has_many :messages, -> {order created_at: :asc}, dependent: :destroy
  has_many :chat_participations, -> {order created_at: :asc}, dependent: :destroy
  has_many :users, through: :chat_participations
  has_one :last_message, -> {order created_at: :desc}, class_name: "Message"
  belongs_to :user # This is the creator of the Chat.

  validates_length_of :subject, maximum: 200

  auto_strip_attributes :subject

  class << self
    # Public: Scope for active Chats.
    #
    # user - User for the query.
    #
    # Returns ActiveRecord::Relation.
    #
    def active_for(user)
      self.includes(:chat_participations).where(chat_participations: {user_id: user.id, archived_at: nil})
    end

    # Public: Scope for all Chats.
    #
    # user - User for the query.
    #
    # Returns ActiveRecord::Relation.
    #
    def all_for(user)
      self.includes(:chat_participations).where(chat_participations: {user_id: user.id})
    end

    # Public: Scope for unread Chats.
    #
    # user - User for the query.
    #
    # Returns ActiveRecord::Relation.
    #
    def unread_by(user)
      self.includes(:chat_participations, :messages).where([
        "(chat_participations.read_at < messages.created_at OR chat_participations.read_at IS NULL)\
          AND chat_participations.user_id = :user_id AND messages.user_id <> :user_id",
        {user_id: user.id}]).order("messages.created_at DESC")
    end

    # Public: Scope for Chats between two or more Users.
    # Notice this method does NOT use SQL join.
    #
    # users - Array of Users.
    #
    # Returns ActiveRecord::Relation.
    #
    def between(*users)
      chat_ids = users.flatten.map do |u|
        ChatParticipation.where(user_id: u.id).pluck(:chat_id).to_set
      end.reduce(:&).to_a
      where(id: chat_ids)
    end
  end

  def users_except(u)
    users.reject { |user| user == u }
  end

  # Public: Checks if there are unread messages for the User.
  #
  # user - User who participates in the Chat.
  #
  # Returns true if there are unread messages for the User.
  #
  def has_unread_messages?(user)
    latest_message = self.last_message
    if latest_message
      chat_participation = self.chat_participations.where(user_id: user.id).first
      chat_participation.try(:unread_message?, latest_message)
    end
  end

  # Public: Marks all messages as read for a User.
  #
  # user - User who participates in the Chat.
  #
  # Returns true if the record saved successfully.
  #
  def read_messages!(user)
    if has_unread_messages?(user)
      user.reset_unread_chats_count
      self.chat_participations.where(user_id: user.id).first.try(:read_messages!)
    end
  end

  # Public: Checks if the Chat has ben archived by the User.
  #
  # user - User who participates in the Chat.
  #
  # Returns true if the Chat has been archived by the User.
  #
  def archived?(user)
    self.chat_participations.where(user_id: user.id).first.try(:archived?)
  end

  # Public: Archives the Chat for the User.
  #
  # user - User who participates in the Chat.
  #
  # Returns true if the record saved successfully.
  #
  def archive!(user)
    self.chat_participations.where(user_id: user.id).first.try(:archive!)
  end

  # Public: Have the User to join the Chat.
  #
  # user - User who is going to participate in the Chat.
  #
  # Returns true if save successfully.
  #
  def join!(user)
    # It loads up all the user because in the case where the chat is saved but the chat_participations have not been saved,
    # this is the only way to ensure we don't have duplicates.
    return if self.chat_participations.map(&:user_id).include?(user.id)
    self.chat_participations.create!(:user => user)
  end
end
