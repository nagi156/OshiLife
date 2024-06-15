class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!

  def show
    @post = Post.find(params[:id])

    # サイドバー適応のため
    @genres = Genre.all.page(params[:sidebar_page]).per(5)
    @total_genres_count = Genre.count
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
end
