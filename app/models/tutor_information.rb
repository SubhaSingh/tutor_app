class TutorInformation < ActiveRecord::Base
	belongs_to :course
	validates :user_id, presence: true
	validates :course_id, presence: true

end
