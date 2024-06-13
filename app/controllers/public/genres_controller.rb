class Public::GenresController < ApplicationController
  before_action :authenticate_user!
  before_action :set_genre

  def index
  end

  def show
    @genre = Genre.find(params[:id])
    @posts = @genre.posts
  end


  private

  def set_genre
    @genres = Genre.all.page(params[:page]).per(5)
  end
end
