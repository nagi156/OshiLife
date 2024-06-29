class Admin::InquiriesController < ApplicationController
  before_action :authenticate_admin!
  before_action :ensure_admin!
  before_action :set_inquiry, except: [:index]
  before_action :set_sidebar

  def index
    @sort_option = params[:sort]

    @inquiries = case @sort_option
                 when 'answred'
                   Inquiry.answered.page(params[:page])
                 when 'unanswered'
                   Inquiry.unanswered.page(params[:page])
                 else
                   Inquiry.all.order(created_at: :desc).order(created_at: :desc).page(params[:page])
                 end
  end

  def show
  end
  
  def create
    @inquiry.new(inquiry_params)
    if @inquiry.save
      redirect
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
    params.require(:inquiry).permit(:message,:answered)
  end

  def set_inquiry
    @inquiry = Inquiry.find(params[:id])
  end

  def ensure_admin!
    redirect_to root_path, alert: "アクセス権限がありません。" unless current_user.admin?
  end

  def set_sidebar
    @show_sidebar = false
  end

end
