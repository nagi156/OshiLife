class Public::SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @model = params[:model]
    @word = params[:word]
    if @model == "ユーザー"
      @records = User.search_for(params[:search], @word).page(params[:page])
    else
      @records = Post.search_for(params[:search], @word).page(params[:page])
    end
    # サイドバーの情報取得のため
    @genres = Genre.all.page(params[:sidebar_page]).per(5)
    @total_genres_count = Genre.count
  end
end
