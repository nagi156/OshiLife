class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!

  def top
    if params[:latest]
      @posts = Post.latest.page(params[:page])
    elsif params[:old]
      @posts = Post.old.page(params[:page])
    elsif params[:most_favorites]
      @posts = Post.most_favorites.page(params[:page])
    else
      @posts = Post.all.order(created_at: :desc).page(params[:page])
    end
    # サイドバー適応のため
    @genres = Genre.all.page(params[:sidebar_page]).per(5)
    @total_genres_count = Genre.count
  end

end
