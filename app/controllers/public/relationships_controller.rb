class Public::RelationshipsController < ApplicationController
  before_action :authenticate_user!

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
    user = User.find(params[:user_id])
    @users = user.followings
  end

  def followers
    user = User.find(params[:user_id])
    @users = user.followeds
  end


end
