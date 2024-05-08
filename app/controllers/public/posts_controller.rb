class Public::PostsController < ApplicationController
  before_action :authenticate_user!
  
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
  end
  
  def update
  end
  
  def destroy
  end
  
  private
  
  def post_params
    params.require(:post).parmit(
      :title,#postモデルの属性
      materials_attributes:[:id,:name, :amount, :_destroy],#材料モデル（子モデル）の属性
      recipes_attributes:[:id, :instructions, :_destroy]#作り方モデル（子モデル）の属性
      )
  end
end
