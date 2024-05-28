class Public::NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @notifications = current_user.notifications.order(create_at: desc).page(prams[:page])
    @notifications.where(checked: false).each do |notification|
      notification.update(checked: true)
    end
  end

  def destroy
    @notificataions = current_user.notifications.destroy_all
    redirect_to notifications_path
  end

end
