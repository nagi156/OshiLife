class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_genre
  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to admin_post_path(@post), notice: "編集しました。"
    else
      flash[:alert] = "編集に失敗しました。内容を確認してください。"
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      redirect_to admin_path, notice: "削除しました。"
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

  def set_genre
    @genres = Genre.all.page(params[:page]).per(5)
  end


end
