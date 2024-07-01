class Relationship < ApplicationRecord
  belongs_to :following, class_name: "User"
  belongs_to :followed, class_name: "User"

  has_one :notification, as: :subject, dependent: :destroy

  include NotificationConcern

  after_create :create_notifications

  def create_notifications
    create_notification(self.followed, self, :followed_me)
  end
end
