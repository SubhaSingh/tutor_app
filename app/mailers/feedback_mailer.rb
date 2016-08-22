class FeedbackMailer < ApplicationMailer

	def report(feedback, current_user)
		@feedback = feedback
		@current_user = current_user
		mail to: 'tutormanagementapp@gmail.com', subject: "Tutor App Feedback"
	end
end
