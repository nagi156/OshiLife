class Relationship < ApplicationRecord
  belongs_to :follower, class_name: 'User', foreign_key: :following_id
  belongs_to :followed, class_name: 'User', foreign_key: :followed_id
end
