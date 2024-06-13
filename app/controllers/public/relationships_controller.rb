class Public::RelationshipsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_genre

  def create
    @user = User.find(params[:user_id])
    following = current_user.relationships.build(followed_id: params[:user_id])
    following.save
  end

  def destroy
    @user = User.find(params[:user_id])
    following = current_user.relationships.find_by(followed_id: params[:user_id])
    following.destroy
  end

  # フォロー/フォロワーの一覧のためのメソッド
  def followings
    @user = User.find(params[:user_id])
    @users = @user.followings
  end

  def followers
    @user = User.find(params[:user_id])
    @users = @user.followeds
  end

  private

  def set_genre
    @genres = Genre.all.page(params[:page]).per(5)
  end


end
