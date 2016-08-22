class CalendarsController < ApplicationController

	

  def show
  	@current_user = User.find(session[:user_id])
  	@date = params[:month] ? Date.parse(params[:month]) : Date.today
  	@current_user_meetings = @current_user.course_meetings.map { |meeting| meeting}
  	@current_user_assessments = @current_user.course_assessments.map { |assessment| assessment}
  	@current_user_events = @current_user_meetings + @current_user_assessments
  
  end
end
