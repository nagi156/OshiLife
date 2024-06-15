class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_genre, except: [:update, :withdraw]
  before_action :all_genre_count, except: [:update, :withdraw]
  before_action :ensure_correct_user, only: [:edit, :update, :unsubscribe, :withdraw]
  before_action :ensure_guest_user, only: [:edit]

  def index
    @users = User.all.page(params[:page])
  end

  def my_page
    @user = User.find(current_user.id)
    @posts = @user.posts.page(params[:page]).order(created_at: :desc)
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page]).order(created_at: :desc)
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
    @like_list = Post.where(id: @user.favorites.pluck(:post_id)).page(params[:page])
  end



  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image, :email, :password, :password_confirmation)
  end

  # サイドバー適応のため
  def set_genre
    @genres = Genre.all.page(params[:sidebar_page]).per(5)
  end

  def all_genre_count
    @total_genres_count = Genre.count
  end

  # アクセス制限のメソッド
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
