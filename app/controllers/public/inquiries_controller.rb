class Public::InquiriesController < ApplicationController
  before_action :authenticate_user!

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
    @inquiries = Inquiry.all.order(created_at: :decs).page(params[:page])
  end

  def show
    @inquiry = Inquiry.find(params[:id])
  end


  private

  def inquiry_params
    params.require(:inquiry).permit(:message)
  end
end
