class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  include SessionsHelper
  include CoursesHelper

   #Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

 

   
  private

    def new_params
      @current_user = User.find(session[:user_id])
      @course = Course.find(params[:course_id])
    end

    def session_params
      @current_user = User.find(session[:user_id])
      @course = Course.find(params[:id])      

    end


    

end
