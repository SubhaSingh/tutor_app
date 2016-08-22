class PostsController < ApplicationController

	include CoursesHelper

	

	def index
		new_params
		@post = Post.new
		@posts = @course.posts.paginate(page: params[:page])
		if course_member?(@current_user, @course)
			render 'index'
		end
	end

	def create
		new_params
		user = { user_id: @current_user.id  }	
		post_user = user.merge( post_params )
		@post = @course.posts.new(post_user)
		if course_member?(@current_user, @course)
			if @post.save && @post.valid?
				flash[:success] = "Message posted!"
				redirect_to course_posts_path(@course)
			else 
				flash[:danger] = "No content"
				redirect_to course_posts_path(@course)
			end
		end

	end


	private

    	def post_params
      		params.require(:post).permit(:content)
    	end

    	

end
