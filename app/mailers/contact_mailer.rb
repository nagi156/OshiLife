class ContactMailer < ApplicationMailer
  # sebjectはタイトル、contentは本文
  def individual_email(user, subject, content)
    @content = content
    mail(to: user.email, subject: subject)
  end

  def bulk_email(user, subject, content)
    @content = content
    mail(to: user.email, subject: subject)
  end

end
