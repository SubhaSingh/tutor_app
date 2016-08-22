class MeetingsController < ApplicationController
	include CoursesHelper

	before_action :new_params
	rescue_from ArgumentError , :with => :known_error

	def new
		@meeting = Meeting.new
	end

	def index
		@meetings = @course.meetings
		@many_meetings = @course.meetings.paginate(page: params[:page])
		if course_member?(@current_user, @course)
			@meeting_member = MeetingMember.new
		end
	end


	def edit
		@meeting = Meeting.find_by_id(params[:id])
		if @current_user.id == @meeting.user_id
			
		else
			redirect_to course_meetings_path(@course)
		end
		
	end

	def create
		@new_date = Date.strptime(meeting_params[:date], "%m/%d/%Y")
		@new_starttime = Time.strptime(meeting_params[:starttime], "%H:%M %p")
		@new_endtime = Time.strptime(meeting_params[:endtime], "%H:%M %p")
		converted_params = { date: @new_date, starttime: @new_starttime, endtime: @new_endtime, name: meeting_params[:name], venue: meeting_params[:venue], notes: meeting_params[:notes] }
		creator = { user_id: @current_user.id  }	
		meeting_creator = creator.merge( converted_params )
		@meeting = @course.meetings.new(meeting_creator)
		if course_member?(@current_user, @course)
			if @meeting.save && @meeting.valid?
				flash[:success] = "Meeting created!"
				redirect_to course_meetings_path(@course)
			else 
				flash[:danger] = "Something went wrong. Please ensure Name, Venue and Date fields are filled and meet stated character length."
				redirect_to new_course_meeting_path(@course)
			end
		end
	end

	def update
		if course_member?(@current_user, @course)
			@meeting = Meeting.find_by_id(params[:id])
      		if @meeting.update_attributes(meeting_params)
        		flash[:success] = "Meeting updated!"
        		redirect_to course_meetings_path(@course)
      		else
        	render 'edit'
      		end
      	end
	end

	def destroy
		@meeting = Meeting.find_by_id(params[:id])
		if @current_user.id == @meeting.user_id
      		@meeting.destroy
      		flash[:success] = "Meeting has been deleted"
      		redirect_to course_meetings_path(@course)
   		end
	end

	def known_error
		flash.now[:danger] = "Something went wrong. Please ensure Name, Venue and Date fields are filled and meet stated character length."
		render 'new'
	end

	private

	def meeting_params
		params.require(:meeting).permit(:name, :venue, :date, :starttime, :endtime, :notes)
	end
end
