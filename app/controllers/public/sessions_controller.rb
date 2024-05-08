# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  before_action :configure_sign_in_params
  before_action :user_state, only: [:create]
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
    redirect_to posts_path, notice: "ゲストさんでログインしました。"
  end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:name, :password])
  end
  def user_state
    user = User.find_by(email: params[:user][:email])
    return if user.nil?
    return unless user.valid_password?(params[:user][:password])
    return unless user.is_active?
      redirect_to posts_path
    return　redirect_to new_user_registration_path, alert: "退会済みです。再度ご登録をしてご利用ください"
  end

end
