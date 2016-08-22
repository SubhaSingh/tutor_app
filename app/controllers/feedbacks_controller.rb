class FeedbacksController < ApplicationController

	def new
		@feedback = Feedback.new
	end

	def create
		@current_user = User.find(session[:user_id])
		@feedback = Feedback.new(feedback_params)
			if @feedback.save 
				FeedbackMailer.report(@feedback, @current_user).deliver_now
				flash[:success] = "Feedback sent"
				redirect_to dashboard_url
			elsif 
				render 'new'
			end
	end

	private

	def feedback_params
		params.require(:feedback).permit(:clarity, :conciseness, :familiarity, :responsiveness, :consistency, :attractiveness, :efficiency, :forgiving, :informativeness, :devices, :comments)
	end

end
