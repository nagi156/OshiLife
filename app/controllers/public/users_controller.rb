class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update]
  before_action :ensure_guest_user, only: [:edit]

  def index
    @users = User.all.page(params[:page]).per(8).order(created_at: :desc)
  end

  def my_page
    @user = User.find(current_user.id)
    @posts = @user.posts
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to my_page_path, notice: "編集しました。"
    else
      flash[:alert] = "編集に失敗しました。"
      render :edit
    end
  end

  # 退会確認画面
  def unsubscribe
    @user = current_user
  end

  # 退会機能
  def withdraw
    @user = User.find(current_user.id)
    # is_activeをfalseにして論理削除する
    @user.update(is_active: false)
    reset_session
    flash[:notice] = "退会しました。"
    redirect_to about_path
  end
  
  # いいね一覧
  def likes
    @user = User.find(params[:id])
    @likes = Favorite.where(user_id: @user.id).pluck(:post_id)
    @likes_list = Post.find(@likes)
  end



  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to my_page_path
    end
  end

  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.guest_user?
      redirect_to my_page_path, alert: "ゲストユーザーはプロフィール編集できません。"
    end
  end

end
