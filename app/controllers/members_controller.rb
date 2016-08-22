class MembersController < ApplicationController
	include CoursesHelper

	before_action :new_params

	def index
		@convenor = course_convenor?(@current_user, @course)
		if course_member?(@current_user, @course)

		end
	end

	#Destroy user tutor association and create lecturer assiociation
	def lecturer
		if course_convenor?(@current_user, @course)
			@user = Tutor.find_by(params[:tutor_id]).user_id
			@tutor = Tutor.find_by(params[:tutor_id])
			@tutor.destroy
			Lecturer.create!(user_id: @user, course_id: @course.id)
			flash[:success] = "Changed course member to lecturer role"
			redirect_to course_members_path(@course)
		end
	end 

	#Destroy user lecturer association and create tutor assiociation
	def tutor
		if course_convenor?(@current_user, @course)
			@user = Lecturer.find_by(params[:lecturer_id]).user_id
			@lecturer = Lecturer.find_by(params[:lecturer_id])
			@lecturer.destroy
			Tutor.create!(user_id: @user, course_id: @course.id)
			flash[:success] = "Changed course member to tutor role"
			redirect_to course_members_path(@course)
		end
	end

	def delete_tutor
		if course_convenor?(@current_user, @course)
			@user = Tutor.find_by(params[:tutor_id]).user_id
			@tutor = Tutor.find_by(params[:tutor_id])
			@tutor.destroy
			redirect_to course_members_path(@course)
		end
	end

	def delete_lecturer
		if course_convenor?(@current_user, @course)
			@user = Lecturer.find_by(params[:lecturer_id]).user_id
			@lecturer = Lecturer.find_by(params[:lecturer_id])
			@lecturer.destroy
			redirect_to course_members_path(@course)
		end
	end
end
