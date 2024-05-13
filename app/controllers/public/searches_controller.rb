class Public::SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @model = params[:model]
    @word = params[:word]
    if @model == "ユーザー"
      @records = User.search_for(params[:search], @word)
    else
      @records = Post.search_for(params[:search], @word)
    end
  end
end
