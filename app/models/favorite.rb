class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :post

  has_one :notification, as: :subject, dependent: :destroy

  after_create_commit :create_notification

  validates :user_id, uniqueness: {scope: :post_id}

  private

  def create_notification
    Notification.create(subject: self, user: self.post.user, action_type: :liked_to_own_post)
  end

end
