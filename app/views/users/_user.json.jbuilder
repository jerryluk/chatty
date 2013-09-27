if user.nil?
  user.nil!
else
  json.extract! user, :user_type, :edmodo_id, :first_name, :last_name, :title, :avatar_url, :thumb_url
end
