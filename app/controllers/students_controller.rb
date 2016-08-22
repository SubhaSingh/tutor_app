class StudentsController < ApplicationController
	include CoursesHelper
	

	before_action :new_params

	def import
		if course_lecturer?(@current_user, @course) || course_convenor?(@current_user, @course)	
			@assessment = Assessment.find_by_id(params[:assessment_id])
			if params[:file] == nil
				redirect_to course_assessment_path(@course, @assessment)
			else
				Student.import(params[:file], @assessment, @current_user)
				redirect_to course_assessment_path(@course, @assessment)
				flash[:success] = "CSV file successfully imported"
			end
		else
			flash[:danger] = "Invalid CSV format"
			redirect_to course_assessment_path(@course, @assessment)
		end
	end

	def edit
		if course_member?(@current_user, @course)
			@student = Student.find_by(params[:id])

		end
	end


	def update
		if course_member?(@current_user, @course)
			@assessment = Assessment.find_by_id(params[:assessment_id])
			user = { user_id: @current_user.id  }	
			@user = User.find_by_id(@current_user.id)
			student_user = user.merge( student_params )
			
			@student = Student.find_by_id(params[:id])
		
			
			if @student.update_attributes(student_user)

				flash[:success] = "Student information updated!"
				redirect_to course_assessment_path(@course, @assessment)

			else 
				flash[:danger] = 'Could not update student information'
				redirect_to course_assessment_path(@course, @assessment)

			end
		end

	end

	def destroy 
		@assessment = Assessment.find_by_id(params[:assessment_id])
		@student = Student.find_by_id(params[:id])
		if course_convenor?(@current_user, @course) || course_lecturer(@current_user, @course)
			@student.destroy
			flash[:success] = "Student has been deleted"
			redirect_to course_assessment_path(@course, @assessment)
		end

	end

	def remove_all
		@assessment = Assessment.find_by_id(params[:assessment_id])
			if course_convenor?(@current_user, @course) || course_lecturer(@current_user, @course)
				@assessment.students.destroy_all
				flash[:success] = "All students has been deleted"
				redirect_to course_assessment_path(@course, @assessment)
			end
	end



	private 

	def student_params
		params.require(:student).permit(:attendance, :task_completed, :mark)
	end
end
