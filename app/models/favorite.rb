class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :post

  has_one :notification, as: :subject, dependent: :destroy

  validates :user_id, uniqueness: {scope: :post_id}

  include NotificationConcern

  after_create :create_notifications

  def create_notifications
    create_notification(self.post.user, self, :liked_to_own_post)
  end
  
end
