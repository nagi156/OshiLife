class Admin::SearchesController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_genre

  def search
    @model = params[:model]
    @word = params[:word]
    if @model == "ユーザー"
      @records = User.search_for(params[:search], @word).page(params[:page])
    else
      @records = Post.search_for(params[:search], @word).page(params[:page])
    end
  end

  private

  def set_genre
    @genres = Genre.all
  end


end
