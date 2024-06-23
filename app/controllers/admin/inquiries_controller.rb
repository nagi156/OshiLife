class Admin::InquiriesController < ApplicationController
  before_action :authenticate_admin!
  before_action :ensure_admin!
  before_action :set_inquiry, except: [:index]

  def index
    @unanswereds = Inquiry.where(answered: false)
    @answereds = Inquiry.where(answered: true)
  end

  def show
  end

  def update
    if @inquiry.update(inquiry_params)
      redirect_to admin_inquiries_path, notice: "ステータス変更しました。"
    else
      flash[:alert] = "ステータス変更に失敗しました。"
      render :show
    end
  end

  private

  def inquiry_params
    params.require(:inquiry).permit(:answered)
  end

  def set_inquiry
    @inquiry = Inquiry.find(params[:id])
  end

  def ensure_admin!
    redirect_to root_path, alert: "アクセス権限がありません。" unless current_user.admin?
  end

end
