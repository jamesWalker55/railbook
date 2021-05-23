class UserMailer < ApplicationMailer
  default from: 'notifications@railbook.com'

  def welcome_email
    @user = params[:user]
    mail(to: @user.email, subject: 'Welcome to Railbook!')
  end
end
