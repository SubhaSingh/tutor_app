class Feedback < ActiveRecord::Base
	
	validates :clarity, presence: true
	validates :conciseness, presence: true
	validates :familiarity, presence: true
	validates :responsiveness, presence: true
	validates :consistency, presence: true
	validates :attractiveness, presence: true
	validates :efficiency, presence: true
	validates :forgiving, presence: true
	validates :informativeness, presence: true
	validates :devices, presence: true
	
	
end
