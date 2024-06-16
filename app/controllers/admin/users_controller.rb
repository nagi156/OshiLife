class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_genre
  before_action :all_genre_count

  def index
    @users = User.all.page(params[:page])
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_user_path(@user), notice: "編集しました。"
    else
      flash[:alert] = "編集に失敗しました。"
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image, :email, :is_active)
  end

  # サイドバーの情報取得のため
  def set_genre
     @genres = Genre.all.page(params[:sidebar_page]).per(5)
  end

  def all_genre_count
    @total_genres_count = Genre.count
  end
end
