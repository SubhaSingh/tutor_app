class MeetingMember < ActiveRecord::Base
	belongs_to :user
	belongs_to :meeting
	validates :user_id, presence: true
	validates :meeting_id, presence: true
end
