class Public::PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update]
  before_action :ensure_guest_user, except: [:index, :show]

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
      redirect_to posts_path
    else
      flash.now[:alert] = "投稿に失敗しました。投稿内容を再度ご確認ください。"
      render :new
    end
  end

  def index
    if params[:latest]
      @posts = Post.latest.page(params[:page])
    elsif params[:old]
      @posts = Post.old.page(params[:page])
    elsif params[:most_favorites]
      @posts = Post.most_favorites.page(params[:page])
    else
      @posts = Post.all.page(params[:page])
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
      :title,:complete_image,#postモデルの属性
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
      redirect_to request.referer, alert: "閲覧のみ可能です。ご利用の際はご登録してご利用ください。"
    end
  end
end
