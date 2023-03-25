class UsersFollowed < ApplicationRecord
  acts_as_paranoid

  belongs_to :follower, class_name: User.name
  belongs_to :followed, class_name: User.name

  validates :user_id, :uniqueness, scope: :followed_id
end
