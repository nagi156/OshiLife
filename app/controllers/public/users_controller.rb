class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update]
  before_action :ensure_guest_user, only: [:edit]

  def index
    @users = User.all
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
      render :edit
      flash[:alert] = "編集に失敗しました。"
    end
  end
  
  # 退会確認画面
  def unsubscribe
    @user = current_user
  end
  
  # 退会機能
  def withdraw
    @user = current_user
    # is_activeをfalseにして論理削除する
    @user.update(is_acttive: false)
    reset_session
    flash[:notice] = "退会しました。"
    redirect_to about_path
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
