class Admin::InquiriesController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_inquiry, only: [:show, :respond, :send_mail]
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
    # assign_attributes: オブジェクトの属性を一括して設定するが、データベースへの保存は行わない。
    @inquiry.assign_attributes(response_params.merge(answered: 'answered'))

    # context: :admin: バリデーションのコンテキストを指定し、特定の条件下でのみバリデーションを実行する
    if @inquiry.save(context: :admin)
      ContactMailer.response_email(@inquiry).deliver_now
      redirect_to send_mail_admin_inquiry_path, notice: 'ステータス変更と返信が完了しました。'
    else
      flash[:alert] = "送信に失敗しました。"
      flash[:inquiry_errors] = @inquiry.errors.full_messages
      redirect_to admin_inquiry_path(@inquiry)
    end
  end

  def send_mail
  end


  private

  def response_params
    params.require(:inquiry).permit(:response)
  end

  def set_inquiry
    @inquiry = Inquiry.find(params[:id])
  end

  def set_sidebar
    @show_sidebar = false
  end

end
