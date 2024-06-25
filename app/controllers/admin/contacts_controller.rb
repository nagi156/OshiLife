class Admin::ContactsController < ApplicationController
  before_action :authentication_admin!
  before_action :set_sidebar

  def send_individual_email
    user = user.find(params[:user_id])
    subject = params[:subject]
    content = params[:content]
    ContactMailer.individual_email(user, subject, content).deliver_now
    redirect_to admin_contact_path, notice: 'メールの送信が完了しました。'
  end

  def send_bulk_email
    subject = params[:subject]
    content = params[:content]
    User.where(is_active: true).find_each do |user|
      ContactMailer.bulk_email(user, subject, content).deliver_now
    end
    redirect_to admin_contact_path, notice: 'メールの一斉送信が完了しました。'
  end

  private

  def set_sidebar
    @show_sidebar = false
  end

end
