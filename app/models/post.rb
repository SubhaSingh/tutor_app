class Post < ActiveRecord::Base
	belongs_to :course
	belongs_to :user
	default_scope -> { order(created_at: :desc) }
	validates :content, presence: true
	validates :user_id, presence: true
	
	


end
