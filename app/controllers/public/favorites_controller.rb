class Public::FavoritesController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_guest_user

  def create
    @post = Post.find(params[:post_id])
    @favorite = current_user.favorite.create(post_id: @post.id)
    redirect_to request.referer
  end

  def destroy
    @post = Post.find(params[:post_id])
    @favorite = current_user.favorite.find_by(post_id: @post.id)
    @favorite.destroy
    redirect_to request.referer
  end
  
  private

  def ensure_guest_user
    if current_user&.guest_user?
      redirect_to request.referer, alert: "閲覧のみ可能です。ご利用の際はご登録してご利用ください。"
    end
  end

end
