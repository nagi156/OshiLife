class Public::PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update]
  before_action :ensure_guest_user, except: [:index, :show]
  before_action :main_genres, except: [:index, :destroy]
  before_action :set_genre, except: [:destroy]
  before_action :all_genre_count, except: [:destroy]

  def new
    @post = Post.new
    @material = @post.materials.build
    @recipe = @post.recipes.build
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      flash[:notice] = "投稿しました"
      redirect_to post_path(@post)
    else
      flash.now[:alert] = "投稿に失敗しました。投稿内容を再度ご確認ください。"
      render :new
    end
  end

  def index
    @sort_option = if params[:latest]
                     'latest'
                   elsif params[:old]
                     'old'
                   elsif params[:most_favorites]
                     'most_favorites'
                   elsif params[:following_ids]
                     'following'
                   else
                     'default'
                   end

    @posts = case @sort_option
             when 'latest'
               Post.latest.page(params[:page])
             when 'old'
               Post.old.page(params[:page])
             when 'most_favorites'
               Post.most_favorites.page(params[:page])
             when 'following'
               Post.following(user_id: current_user.following_ids).page(params[:page])
             else
               Post.all.order(created_at: :desc).page(params[:page])
             end
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post), notice: "編集しました。"
    else
      flash[:alert] = "編集に失敗しました。内容を確認してください。"
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      redirect_to my_page_path
    else
      flash[:alert] = "削除できませんでした。"
      render :show
    end
  end

  private

  def post_params
    params.require(:post).permit(
      :title,:complete_image, :genre_id,#postモデルの属性
      materials_attributes:[:id,:name, :amount,:_destroy],#材料モデル（子モデル）の属性
      recipes_attributes:[:id, :instructions, :recipe_image, :_destroy]#作り方モデル（子モデル）の属性
      )
  end

  def ensure_correct_user
    @post = Post.find(params[:id])
    unless @post.user_id == current_user.id
      redirect_to posts_path
    end
  end

  def ensure_guest_user
    if current_user&.guest_user?
      redirect_to(request.referer || root_path, alert: "閲覧のみ可能です。ご利用の際はご登録してご利用ください。")
    end
  end
  # メインコンテンツのジャンル取得
  def main_genres
    @main_genres = Genre.all
  end

  # サイドバーの情報取得のため
  def set_genre
    @genres = Genre.all.page(params[:sidebar_page]).per(5)
  end

  def all_genre_count
    @total_genres_count = Genre.count
  end
end
