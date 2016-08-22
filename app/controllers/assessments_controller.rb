class AssessmentsController < ApplicationController
	include CoursesHelper

	before_action :new_params
	rescue_from ArgumentError , :with => :known_error

	def new
		@assessment = Assessment.new
	end

	def index
		@assessments = @course.assessments
		@many_assessments = @course.assessments.paginate(page: params[:page])
		if course_member?(@current_user, @course)
			@assessment_tutor = AssessmentTutor.new
		end
	end

	def show
		if course_member?(@current_user, @course)
			@assessment = Assessment.find_by_id(params[:id])
			@student_assessment_params = Assessment.find_by(params[:assessment_id])
			#search text
			if params[:search]
				student_name = params[:search]
				student_number = params[:search]
				@search = @assessment.students.where("name ILIKE ? OR student_number LIKE ?", "%#{student_name}", "%#{student_number}%" ) #search function for students in assessment model
			else
				@search = @assessment.students
			end
			#exporting csv/excel
			@students = @assessment.students
			respond_to do |format| 
				format.html
				format.csv { send_data Assessment.to_csv(@assessment)}
				format.xls { send_data Assessment.to_csv(@assessment, col_sep: "\t")}
			end
		end
	end


	def edit
		@assessment = Assessment.find_by_id(params[:id])
		if @current_user.id == @assessment.user_id
			render 'edit'
			
		else
			redirect_to course_assessments_path(@course)
		end
	end

	def create
		#converting the datepicker and timepicker attributes to the correct format 

		@new_date = Date.strptime(assessment_params[:date], "%m/%d/%Y")
		@new_starttime = Time.strptime(assessment_params[:starttime], "%H:%M %p")
		@new_endtime = Time.strptime(assessment_params[:endtime], "%H:%M %p")
		converted_params = { date: @new_date, starttime: @new_starttime, endtime: @new_endtime, name: assessment_params[:name], venue: assessment_params[:venue], notes: assessment_params[:notes] }
		creator = { user_id: @current_user.id  }	
		assessment_creator = creator.merge( converted_params )
		@assessment = @course.assessments.new(assessment_creator)
		if course_member?(@current_user, @course)
			if @assessment.valid?
				@assessment.save
				flash[:success] = "Assessment created!"
				redirect_to course_assessments_path(@course)
			else 
				flash[:danger] = "Something went wrong. Please ensure Name, Venue and Date fields are filled and meet stated character length."
				redirect_to new_course_assessment_path(@course)
			end
		end
	end

	def update
		if course_member?(@current_user, @course)
			@assessment = Assessment.find_by_id(params[:id])
      		if @assessment.update_attributes(assessment_params)
        		flash[:success] = "Assessment updated!"
        		redirect_to course_assessments_path(@course)
      		else
        	render 'edit'
      		end
      	end
	end

	def destroy
		@assessment = Assessment.find_by_id(params[:id])
		if @current_user.id == @assessment.user_id
      		@assessment.destroy
      		flash[:success] = "Assessment has been deleted"
      		redirect_to course_assessments_path(@course)
   		end
	end

	def known_error
		flash.now[:danger] = "Something went wrong. Please ensure Name, Venue and Date fields are filled and meet stated character length."
		render 'new'
	end

	private

		def assessment_params
			params.require(:assessment).permit(:name, :venue, :date, :starttime, :endtime, :notes)
		end
end

