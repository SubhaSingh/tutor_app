class SolutionsController < ApplicationController
	include CoursesHelper

	before_action :new_params


	def new
		if course_lecturer?(@current_user, @course) || course_convenor?(@current_user, @course)
			@solution = Solution.new
		end
	end

	def index
		@solution = Solution.new
		@many_solutions = @course.solutions.paginate(page: params[:page])
		if course_member?(@current_user, @course)
			
		end
	end

	def create

		creator = { user_id: @current_user.id  }
		answer_creator = creator.merge(solution_params)	
		@solution = @course.solutions.new(answer_creator)
		if course_member?(@current_user, @course)
			if  @solution.valid?
				@solution.save
				flash[:success] = "File uploaded!"
				redirect_to course_solutions_path(@course)
			else 
				flash[:danger] = 'Something went wrong. Only PDF, EXCEL, WORD, TEXT or Image(png, gif, jpeg) files are allowed.'
				redirect_to course_solutions_path(@course)
			end
		end
	end

	def destroy
		@solution = Solution.find_by_id(params[:id])
		if @current_user.id == @solution.user_id
      		@solution.destroy
      		flash[:success] = "File has been deleted"
      		redirect_to course_solutions_path(@course)
   		end
	end

	private

	def solution_params
        params.require(:solution).permit(:answer)
    end

    
end
