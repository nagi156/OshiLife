class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  has_one :notification, as: :subject, dependent: :destroy

  after_create_commit :create_notification

  private

  def create_notification
    Notification.create(subject: self, user: self.post.user, action_type: :commented_to_own_post)
  end
end
