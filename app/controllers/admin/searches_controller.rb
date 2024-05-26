class Admin::SearchesController < ApplicationController
  before_action :authenticate_admin!

  def search
    @model = params[:model]
    @word = params[:word]
    if @model == "ユーザー"
      @records = User.search_for(params[:search], @word).page(params[:page])
    else
      @records = Post.search_for(params[:search], @word).page(params[:page])
    end
  end
end
