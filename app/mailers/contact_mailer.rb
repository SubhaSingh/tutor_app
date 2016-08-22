class ContactMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.contact_mailer.send_message.subject
  #
  def send_message(contact)
  	@contact = contact
  	mail to: 'tutormanagementapp@gmail.com', subject: @contact.subject 
    
  end
end
