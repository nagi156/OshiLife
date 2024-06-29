class Admin::InquiriesController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_inquiry, except: [:index]
  before_action :set_sidebar

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
  end

  def respond
      @inquiry.update(response_params)
      @inquiry.update(answered: 'answered')

      # メールの送信
      ContactMailer.response_email(@inquiry).deliver_now

      redirect_to admin_inquiries_path, notice: 'ステータス変更と返信が完了しました。'
  end

  private

  def set_inquiry
    @inquiry = Inquiry.find(params[:id])
  end

  def response_params
    params.require(:inquiry).permit(:response)
  end

  def set_sidebar
    @show_sidebar = false
  end

end
