class Public::NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @notifications = current_user.notifications.order(created_at: :desc).page(params[:page])
    @notifications.where(checked: false).each do |notification|
      notification.update(checked: true)
    end
    # サイドバーの情報取得のため
    @genres = Genre.all.page(params[:sidebar_page]).per(5)
    @total_genres_count = Genre.count
  end

  def destroy
    @notificataions = current_user.notifications.destroy_all
    redirect_to notifications_path
  end

end
