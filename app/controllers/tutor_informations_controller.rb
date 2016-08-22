class TutorInformationsController < ApplicationController
	include CoursesHelper

	before_action :new_params

	def new
		@info = @course.tutor_information
		if @info.nil?
				@info = TutorInformation.new
			else 
				render 'edit'
			end
	end

	def index
		new_params
		@info = @course.tutor_information
		if course_member?(@current_user, @course)
			if @info.nil?
				@info = TutorInformation.new
			else 
				@info = @course.tutor_information
			end
	
		end
	end


	def edit
		new_params
		@info = TutorInformation.find_by_id(params[:id])
		if !course_tutor?(@current_user, @course)
		end
	end

	def update
		new_params
		user = { user_id: @current_user.id  }	
		info_user = user.merge( info_params )
		@info = @course.tutor_information
		if @info.update_attributes(info_user)
				flash[:success] = "Tutor Information updated!"
				redirect_to course_tutor_informations_path(@course)
		end
	end

	 def create
	 	user = { user_id: @current_user.id, course_id: @course.id }	
		info_user = user.merge( info_params )
		@info = TutorInformation.new(info_user)
		if @info.save and @info.valid?
				flash[:success] = "Tutor Information created!"
				redirect_to course_tutor_informations_path(@course)
		else 
			render 'new'
		end
	 end
	private 

	def info_params
		params.require(:tutor_information).permit(:content)
	end



end
