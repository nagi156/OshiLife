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
    @genres = Genre.all.page(params[:page]).per(5)
  end
end
