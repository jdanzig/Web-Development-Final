class UserMailer < ApplicationMailer
  default :from => 'jdanzig@uchicago.edu'

  def forgot_password(user)
    @user = user
    mail :to => @user.email_addressee, :subject => 'Reset your password'
  end
end
