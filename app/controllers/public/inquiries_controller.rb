class Public::InquiriesController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_accessible_user
  before_action :set_sidebar

  def new
    @inquiry = current_user.inquiries.new
  end

  def create
    @inquiry = current_user.inquiries.new(inquiry_params)
    if @inquiry.save
      redirect_to inquiry_path(@inquiry), notice: 'お問い合わせを送信しました。'
    else
      flash[:alert] = "送信に失敗しました。"
      render :new
    end
  end

  def index
    @sort_option = if params[:answered]
                      'answered'
                   elsif params[:unanswered]
                      'unanswered'
                   else
                      'default'
                   end

    @inquiries = case @sort_option
                 when 'answered'
                   Inquiry.answered.page(params[:page])
                 when 'unanswered'
                   Inquiry.unanswered.page(params[:page])
                 else
                   Inquiry.all.order(created_at: :desc).page(params[:page])
                 end
  end


  def show
    @inquiry = Inquiry.find(params[:id])
  end


  private

  def inquiry_params
    params.require(:inquiry).permit(:title,:message)
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
