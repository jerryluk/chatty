class ChatCacheSweeper
  include Sidekiq::Worker

  sidekiq_options :queue => :high

  def perform(chat_id)
    chat = Chat.includes(:users).find(chat_id)
    chat.users.each do |user|
      user.reset_unread_chats_count
    end
  end
end
