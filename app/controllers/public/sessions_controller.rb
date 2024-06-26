# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params
  before_action :user_state, only: [:create]
  before_action :set_sidebar
  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  def after_sign_in_path_for(resource)
    flash[:notice] = "ログインしました。"
    posts_path
  end

  def after_sign_out_path_for(resource)
    flash[:notice] = "ログアウトしました。"
    about_path
  end

  def guest_sign_in
    user = User.guest
    sign_in user
    redirect_to posts_path, notice: "ゲスト(閲覧専用)でログインしました。"
  end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def user_state
    user = User.find_by(email: params[:user][:email])  # メールアドレスでユーザーを検索
    return if user.nil?
    return unless user.valid_password?(params[:user][:password])
    return if user.is_active
    redirect_to new_user_registration_path, alert: "退会済みです。再度、登録してご利用ください。"
  end


  def set_sidebar
    @show_sidebar = false
  end

end
