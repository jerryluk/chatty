if message.nil?
  json.nil!
else
  json.extract! message, :id, :chat_id, :user_id, :content, :created_at
  json.user do
    json.partial! "users/user", user: message.user
  end
end
