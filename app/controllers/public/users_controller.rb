class Public::UsersController < ApplicationController
  before_action :authenticate_user!, except: [:new, :destroy]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:name])
  end

  def edit
    @user = User.find(params[:name])

  end

  def update

  end

end
