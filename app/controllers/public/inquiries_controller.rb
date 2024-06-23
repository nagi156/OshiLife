class Public::InquiriesController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user
  before_action :ensure_guest_user

  def new
    @inquiry = current_user.inquiries.build
  end

  def create
    @inquiry = current_user.inquiries.build(inquiry_params)
    if @inquiry.save
      redirect_to inquiries_path, notice: 'お問い合わせを送信しました。'
    else
      render :new
    end
  end

  def index
    @inquiries = current_user.inquiries.order(created_at: :decs).page(params[:page])
  end

  def show
    @inquiry = Inquiry.find(params[:id])
  end


  private

  def inquiry_params
    params.require(:inquiry).permit(:message)
  end

  def ensure_correct_user
    @inquiry = Inquiry.find(params[:id])
    unless @inqui.user_id == current_user.id
      redirect_to inquiries_path
    end
  end

  def ensure_guest_ryuser
    if current_user&.guest_user?
      redirect_to request.referer, alert: "ご利用の際はご登録してご利用ください。"
    end
  end
end
