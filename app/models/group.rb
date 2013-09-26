class Group < ActiveRecord::Base
  serialize :owner_ids
  has_many :group_memberships, dependent: :destroy
  has_many :users, through: :group_memberships
end
