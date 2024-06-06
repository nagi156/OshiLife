class Public::GenresController < ApplicationController
   before_action :authenticate_user!

  def index
    @genres = Genre.all
  end

  def show
    @genre.find(params[:id])
    @posts = @genre.posts
  end
end
