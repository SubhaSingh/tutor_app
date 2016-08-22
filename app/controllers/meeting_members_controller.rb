class MeetingMembersController < ApplicationController
	include CoursesHelper

	before_action :new_params

	def create
		user = { user_id: @current_user.id  }
		@meeting = Meeting.find_by_id(params[:meeting_id])
		meeting = { meeting_id: @meeting.id }
		user_meeting_params = user.merge( meeting )
		MeetingMember.create!(user_meeting_params)
		#respond_to do |format|
      	#	format.html { redirect_to course_meetings_path(@course) }
      		#format.js
    	#end
    	redirect_to course_meetings_path(@course)
	end

	def destroy
		@meeting = Meeting.find_by_id(params[:meeting_id])
		@meeting_member = MeetingMember.find_by_id(params[:id])
		@meeting_member.destroy
		#respond_to do |format|
      	#	format.html { redirect_to course_meetings_path(@course) }
      		#format.js
    	#end
    	redirect_to course_meetings_path(@course)
		
	end


end
