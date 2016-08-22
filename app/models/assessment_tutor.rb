class AssessmentTutor < ActiveRecord::Base
	belongs_to :user
	belongs_to :assessment
	validates :user_id, presence: true
	validates :assessment_id, presence: true
end
