class PasswordResetsController < ApplicationController
	before_action :get_user, 			only: [:edit, :update]
	before_action :valid_user, 			only: [:edit, :update]
	before_action :check_expiration, 	only: [:edit, :update]

  #Render forgot password view
  def new
  end

  #Find user by email, update reset attributes 
  def create
  	@user = User.find_by(email: params[:password_reset][:email].downcase)
  	if @user
  		@user.create_reset_digest
  		@user.send_password_reset_email
  		flash[:info] = "Email sent with password reset instructions"
  		redirect_to root_url
  	else
  		flash.now[:danger] = "Email address not found"
  		render 'new'
  	end
  end

  def edit
  end

  def update
  	if params[:user][:password].empty?
  		flash[:danger] = "Password cannot be empty"
  		render 'edit'
  	elsif @user.update_attributes(user_params)
  		log_in @user
  		flash[:success] = "Password has been reset."
  		redirect_to @user
  	else
  		render 'edit'
  	end
  end

  private

  	def user_params
  		params.require(:user).permit(:password, :password_confirmation)
  	end

  	#Find user corresponding to the email address submitted
  	def get_user
  		@user = User.find_by(email: params[:email])
  	end

  	#Confirms the user is valid i.e. exists, activated and authenticated
  	def valid_user
  		unless (@user && @user.activated? &&@user.authenticated?(:reset, params[:id]))
  			redirect_to root_url
  		end
  	end

  	#Check expiration of reset_token
  	def check_expiration
  		if @user.password_reset_expired?
  			flash[:danger] = "Password reset link has expired."
  			redirect_to new_password_reset_url
  		end
  	end

end
