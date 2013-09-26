class User < ActiveRecord::Base
  include Edmofu::Models::User
  include HasZone

  has_many :group_memberships, dependent: :destroy
  has_many :groups, through: :group_memberships

  has_zone with: :time_zone

  # Public: Returns the number of unread Chats.
  def unread_chats_count
    # Rails.cache.fetch(unread_chats_count_cache_key) do
      Chat.unread_by(self).count
    # end
  end

  # Public: Clears the cache for unread Chats count.
  def reset_unread_chats_count
    Rails.cache.delete(unread_chats_count_cache_key)
  end

  # Public: Returns the cache key for the unread Chats count.
  def unread_chats_count_cache_key
    "#{self.cache_key}/unread_chats_count"
  end
end
