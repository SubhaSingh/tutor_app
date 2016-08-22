class DashboardController < ApplicationController
	
 	include CoursesHelper
 	
	#Show users courses 
	def show
		
		@user = User.find(session[:user_id])
		
		@courses_convening = @user.courses_convening.map {|course| course}
		@courses_lecturing = @user.courses_lecturing.map {|course| course}
		@courses_tutoring = @user.courses_tutoring.map {|course| course}
		
		@current_user_meetings = @user.course_meetings.map { |meeting| meeting}
  		@current_user_assessments = @user.course_assessments.map { |assessment| assessment}
  		@current_user_events = @current_user_meetings + @current_user_assessments
		render 'show'
	end

	
	

end
