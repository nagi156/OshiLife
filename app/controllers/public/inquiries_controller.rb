class Public::InquiriesController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_accessible_user
  before_action :set_sidebar

  def new
    @inquiry = current_user.inquiries.build
  end

  def create
    @inquiry = current_user.inquiries.build(inquiry_params)
    if @inquiry.save
      redirect_to inquiry_path(inquiry), notice: 'お問い合わせを送信しました。'
    else
      render :new
    end
  end

  def index
    @inquiries = current_user.inquiries.order(created_at: :desc).page(params[:page])
  end

  def show
    @inquiry = Inquiry.find(params[:id])
  end


  private

  def inquiry_params
    params.require(:inquiry).permit(:message)
  end

  def ensure_accessible_user
    unless current_user
      redirect_to inquiries_path, alert: "アクセスが制限されています。"
    end
  end

  def set_sidebar
    @show_sidebar = false
  end
end
