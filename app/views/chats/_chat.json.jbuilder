if chat.nil?
  json.nil!
else
  json.extract! chat, :id, :subject, :user_id
  json.url chat_path(chat)
  json.title chat.subject || chat.users_except(current_user).map { |u| proper_name(u) }.to_sentence
  json.thumb_url (chat.users_except(current_user)).first.thumb_url
  json.last_message do
    json.partial! "messages/message", message: chat.last_message
  end
  json.unread chat.has_unread_messages?(current_user)
end
