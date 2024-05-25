class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!

  def top
    if params[:latest]
      @posts = Post.latest.page(params[:page]).per(8)
    elsif params[:old]
      @posts = Post.old.page(params[:page]).per(8)
    elsif params[:most_favorites]
      @posts = Post.most_favorites.page(params[:page]).per(8)
    else
      @posts = Post.all.page(params[:page]).per(8)
    end
  end

end
