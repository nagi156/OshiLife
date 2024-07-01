class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_one :notification, as: :subject, dependent: :destroy

  validates :comment, presence: true

  include NotificationConcern

  after_create :create_notifications

  def create_notifications
    create_notification(self.post.user, self, :commented_to_own_post)
  end
end
