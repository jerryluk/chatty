class ChatParticipation < ActiveRecord::Base
  belongs_to :chat
  belongs_to :user

  validates_uniqueness_of :user_id, scope: :chat_id

  # Public: Checks if there are messages unread given the most recent Message in Chat.
  #
  # message - most recent Message of the Chat.
  #
  # Returns true if there are Messages created after the last read_at or the Message is created by this User.
  #
  def unread_message?(message)
    (message.user != self.user) and (self.read_at.nil? or self.read_at <= message.created_at)
  end

  # Public: Marks all messages as read.
  #
  # Returns true if the record saved successfully.
  #
  def read_messages!
    self.read_at = Time.zone.now
    save!
  end

  # Public: Checks if the Chat has been archived.
  #
  # Returns true if the Chat is archived.
  #
  def archived?
    !!self.archived_at
  end

  # Public: Archives the Chat.
  #
  # Returns true if the record saved successfully.
  #
  def archive!
    self.archived_at = Time.zone.now
    save!
  end
end
