class UserMailer < ApplicationMailer
  def new_user_request(user)
    @user = user
    mail(to: 'admin@gmail.com', subject: 'New user request')
  end
end