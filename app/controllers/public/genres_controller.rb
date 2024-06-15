class Public::GenresController < ApplicationController
  before_action :authenticate_user!
  before_action :set_genre
  before_action :all_genre_count

  def index
    @main_genres = Genre.all.page(params[:page]).per(5)
  end

  def show
    @genre = Genre.find(params[:id])
    @posts = @genre.posts.page(params[:page])
  end


  private

  def set_genre
    @genres = Genre.page(params[:sidebar_page]).per(5)
  end

  def all_genre_count
    @total_genres_count = Genre.count
  end
end
