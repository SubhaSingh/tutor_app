class ContactsController < ApplicationController

	def new
		@contact = Contact.new
	end

	def create
		@contact = Contact.new(contact_params)
			if @contact.valid?
				@contact.save 
				ContactMailer.send_message(@contact).deliver_now
				flash[:success] = "Message sent"
				redirect_to root_url
			else
				render 'new'
				flash.now[:danger] = "Something went wrong. Please ensure all fields are filled."
			end
	end

	private

	def contact_params
		params.require(:contact).permit(:name, :email, :subject, :content)
	end
end
