class InvitesController < ApplicationController
	include CoursesHelper

	before_action :new_params
	rescue_from ArgumentError, :with => :known_error

	def new
		if course_convenor?(@current_user, @course) || course_lecturer(@current_user, @course)
			@invite = Invite.new
		end
	end
	#Add user to course as tutor or send them an email asking to sign up.
	def create
		
		course = { course_id: @course.id  }
		course_invite = course.merge( invite_params )
		@invite = @course.invites.new(course_invite)
		
		@email = invite_params[:email]
		if @email.nil?
				flash[:danger] = 'Email cannot be blank'
				render 'new'
		elsif @email != @current_user.email
			if (User.find_by_email(@email) != nil) && @invite.valid?
				@invite.save 
				@user = User.find_by_email(@email)
				Tutor.create!(user_id: @user.id, course_id: @course.id)
				flash[:success] = 'User successfully added to course'
				redirect_to course_members_path(@course)
			else
				flash[:danger] = 'Email does not exist in database. User must have an existing account to be invited to join a course. Sign up email sent to supplied email address'
				InviteMailer.invite(@current_user, @course, @email).deliver_now
				redirect_to course_members_path(@course)
			end
		else
			render 'new'
			flash.now[:danger] = "You are already the course convenor, you may not invite yourself to join the course."
		end
	end

	private 

		def invite_params
			 params.require(:invite).permit(:email)
		end

		def known_error
			flash.now[:danger] = 'Email cannot be blank'
			render 'new'
		end
end
