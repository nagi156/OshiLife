class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_genre

  def top
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

  private

  def set_genre
     @genres = Genre.all.page(params[:page]).per(5)
  end

end
