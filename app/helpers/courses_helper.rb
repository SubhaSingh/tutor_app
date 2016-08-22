module CoursesHelper

private
	#Confirms user is course convenor before deleting/editing course
    def course_convenor?(current_user, course)
      convenor = User.find_by_id(course.convenor.user_id)
      if convenor == current_user
        return true
      else
        return false
      end
    end

    #Confirms user is a course tutor before 
    def course_lecturer?(current_user, course)
      !course.lecturers.where(user_id: current_user.id, course_id: course.id).empty?
    end

    #Confirms user is a course tutor before 
    def course_tutor?(current_user, course)
      !course.tutors.where(user_id: current_user.id, course_id: course.id).empty?
    end

    def course_member?(current_user, course)
      @convenor = User.find_by_id(course.convenor.user_id)
      if @convenor == current_user
        return true
      elsif !course.tutors.where(user_id: current_user.id, course_id: course.id).empty?
        return true
      elsif  !course.lecturers.where(user_id: current_user.id, course_id: course.id).empty?
        return true
      else 
        return false
      end
    end

     def convenor
       @convenor = User.find(@course.convenor.user_id).name
    end

    

end
