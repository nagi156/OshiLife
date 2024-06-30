class ContactMailer < ApplicationMailer
  def response_email(inquiry)
    @inquiry = inquiry
    mail(to: @inquiry.user.email, subject: 'お問い合わせについて')
  end
end
