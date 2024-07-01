class NotificationMailer < ApplicationMailer
  def notification_email(user, notification)
    @user = user
    @notification = notification
    @subject = notification.subject
    mail(to: @user.email, subject: "Oshi Lifeからの通知です。")
  end
end
