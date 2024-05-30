class Relationship < ApplicationRecord
  belongs_to :following, class_name: "User"
  belongs_to :followed, class_name: "User"

  has_one :notification, as: :subject, dependent: :destroy

  after_create_commit :create_notification

  private

  def create_notification
    Notification.create(subject: self, user: followed, action_type: :followed_me)
  end
end
