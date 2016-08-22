class InviteMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.invite_mailer.invite.subject
  #
  def invite(current_user, course, email)
  	@user = current_user
  	@course = course.name
    mail to: email, subject: "Invite"
  end
end
