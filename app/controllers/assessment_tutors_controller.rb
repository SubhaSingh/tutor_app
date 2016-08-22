class AssessmentTutorsController < ApplicationController
	include CoursesHelper

	before_action :new_params

	def create
		user = { user_id: @current_user.id  }
		@assessment = Assessment.find(params[:assessment_id])
		assessment = { assessment_id: @assessment.id }
		user_assessment_params = user.merge( assessment )
		AssessmentTutor.create!(user_id: @current_user.id, assessment_id: @assessment.id)
		
		redirect_to course_assessments_path(@course)
	end

	def destroy
		@assessment_tutor = AssessmentTutor.find(params[:id])
		@assessment_tutor.destroy
	
		redirect_to course_assessments_path(@course)
	end

end
