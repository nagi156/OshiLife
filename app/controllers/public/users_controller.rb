class Public::UsersController < ApplicationController
  before_action :authenticate_user!, except: [:new, :destroy]

  def index
    @users = User.all
  end

  def my_page
    @my_page = User.find(current_user.id)
    @posts = @my_page.posts
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end

  def edit
    @user = User.find(params[:id])

  end

  def update

  end

end
