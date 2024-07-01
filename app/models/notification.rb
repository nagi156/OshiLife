class Notification < ApplicationRecord
  belongs_to :subject, polymorphic: true
  belongs_to :user

  enum action_type: {commented_to_own_post: 0, liked_to_own_post: 1, followed_me: 2, chated_me: 3}

  after_create :send_notification_email

  private

  def send_notification_email
    NotificationMailer.notification_email(user, self).deliver_later
  end

end