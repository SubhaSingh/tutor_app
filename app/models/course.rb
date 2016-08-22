class Course < ActiveRecord::Base
	#Destroy the related lecturer, tutor and convenor associations if course is deleted
	has_many :lecturers,	dependent: :destroy
	has_many :tutors, 		dependent: :destroy
	has_one  :convenor,		dependent: :destroy

	has_one  :course_convenor, through: :convenor, source: :user
	has_many :course_lecturers, through: :lecturers, source: :user 
	has_many :course_tutors, through: :tutors, source: :user
	
	has_one :tutor_information, dependent: :destroy
	has_one :member, dependent: :destroy
	has_one :availability, dependent: :destroy
	has_many :solutions, dependent: :destroy
	has_many :meetings, dependent: :destroy
	has_many :posts, dependent: :destroy
	has_many :assessments, dependent: :destroy
	has_many :invites

	validates :name, presence: true, length: { maximum: 12 }
end
