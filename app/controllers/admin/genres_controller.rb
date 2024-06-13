class Admin::GenresController < ApplicationController
  before_action :authenticate_admin!
  before_action :find_genre, only: [:show,:edit, :update, :destroy]
  before_action :set_genre, only: [:index, :show, :edit]

  def index
    @genre = Genre.new
  end

  def show
    @posts = @genre.posts
  end

  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      redirect_to admin_genres_path, notice: 'ジャンルを追加しました。'
    else
      flash.now[:alert] = "ジャンル登録に失敗しました。内容をご確認ください。"
      @genres = Genre.all
      render :index
    end
  end

  def edit
  end

  def update
    if @genre.update(genre_params)
      redirect_to admin_genres_path, notice: 'ジャンルを更新しました。'
    else
      render :edit
    end
  end

  def destroy
    @genre.destroy
    redirect_to admin_genres_path, notice: 'ジャンルを削除しました。'
  end

  private

  def find_genre
    @genre = Genre.find(params[:id])
  end

  def set_genre
    @genres = Genre.all.page(params[:page]).per(5)
  end


  def genre_params
    params.require(:genre).permit(:name)
  end

end
