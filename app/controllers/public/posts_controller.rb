class Public::PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update]

  def new
    @post = Post.new
    @material = @post.materials.build
    @recipe = @post.recipes.build
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to posts_path, notice: "投稿しました"
    else
      render :new
      flash[:alert] = "投稿に失敗しました。投稿内容を再度ご確認ください。"
    end
  end

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post), notice: "編集しました。"
    else
      render :edit
      flash[:alert] = "編集に失敗しました。内容を確認してください。"
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      redirect_to my_page_path
    else
      render :show
      flash[:alert] = "削除できませんでした。"
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
end
