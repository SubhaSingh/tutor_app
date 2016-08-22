class Meeting < ActiveRecord::Base
	belongs_to :course
	has_many :meeting_members, dependent: :destroy
	validates :name, presence: true, length: { maximum: 20 }
	validates :venue, presence: true, length: { maximum: 12 }
	validates :date, presence: true 
	validates :user_id, presence: true
	validates :course_id, presence: true
	validates :starttime, presence: true
	default_scope -> { order(date: :desc) }
end
