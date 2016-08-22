class UsersController < ApplicationController
  #only allow user to edit and update user profile info if logged in 
 before_action :logged_in_user, only: [:edit, :update, /:destroy/]
 #Only allow user to update and edit user profile info if they are that particular user 
 before_action :correct_user,   only: [:edit, :update]
 #Restrict delete user action to superadmins only 
 before_action :superadmin_user, only: [:destroy]

 #Create new user - direct to signup page
  def new
  	@user = User.new
  end

  #Show user profile
  def show
  	@user = User.find(params[:id])
  end

 #Create new user based on attributes entered in signup page
  def create
  	@user = User.new(user_params)
  	if @user.save
  		@user.send_activation_email
  		flash[:info] = "Please check your email to activate your account"
  		redirect_to root_url
  	else
  		render 'new'
  	end
  end

  #delete user from application
  def destroy
    User.find_by_id(params[:id]).destroy
    flash[:success] = "User has been deleted"
    redirect_to users_url
  end

#Edit user profile info
  def edit
  end

#Update user profile info, handles both successful and unseccussful cases
  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated successfully"
      redirect_to @user
    else 
      render 'edit'
    end
  end


  private

  	def user_params
  		params.require(:user).permit(:name, :email, :password, :password_confirmation, :avatar)
  	end
    
    #Before filters

    #Confirms the correct user
    def correct_user 
      @user = User.find_by_id(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
    #Unless the user is superadmin redirect them to the home page
    def superadmin_user
      redirect_to(root_url) unless current_user.superadmin?
    end


end
