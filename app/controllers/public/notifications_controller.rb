class Public::NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @notifications = current_user.notifications.order(created_at: :desc).page(params[:page])
    @notifications.where(checked: false).each do |notification|
      notification.update(checked: true)
    end
    @genres = Genre.all.page(params[:page]).per(5)
  end

  def destroy
    @notificataions = current_user.notifications.destroy_all
    redirect_to notifications_path
  end

end
