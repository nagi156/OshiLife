class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_one :notification, as: :subject, dependent: :destroy

  validates :comment, presence: true

  after_create_commit :create_notifications

  private

  def create_notifications
    Notification.create(subject: self, user: self.post.user, action_type: :commented_to_own_post)
  end
end
