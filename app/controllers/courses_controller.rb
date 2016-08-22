class CoursesController < ApplicationController
 
	
 

  def new
    @course = Course.new
  end

  def show
    session_params
    convenor
    render 'home'
 
  end

  def create
    
    @course = Course.new(course_params)
    @current_user = session[:user_id]
    if @course.save
      Convenor.create!( course_id: @course.id,
                            user_id: @current_user)
      flash[:success] = 'New course created'
      redirect_to dashboard_url
    else 
      render 'new'
    end
  end

  def edit
    session_params
    if course_convenor?(@current_user, @course)
      render 'edit'
    else
      flash[:info] = "Only course convenor may edit"
      redirect_to dashboard_url
    end
  end

  def update
    session_params
    if course_convenor?(@current_user, @course)
      if @course.update_attributes(course_params)
        flash[:success] = "Course updated"
        redirect_to dashboard_url
      else
        render 'edit'
      end
    end
  end

  

  def destroy
    session_params
    if course_convenor?(@current_user, @course)
      @course.destroy
      flash[:success] = "Course has been deleted"
      redirect_to dashboard_url
    end
  end

  private 

    def course_params
        params.require(:course).permit(:name)
    end

    def known_error
      flash.now[:danger] = 'Maximum character length is 12'
      render 'new'
    end 
   
end
