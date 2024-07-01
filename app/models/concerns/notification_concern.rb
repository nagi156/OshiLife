module NotificationConcern
  extend ActiveSupport::Concern

  included do
    def create_notification(user, subject, action_type)
      Notification.create!(
        user: user,
        subject: subject,
        action_type: action_type
      )
    end
  end
end