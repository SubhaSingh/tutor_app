class Solution < ActiveRecord::Base
	belongs_to :course

	validates :user_id, presence: true
	validates :course_id, presence: true
	default_scope -> { order(created_at: :desc) }
	
	has_attached_file 	:answer,
	:storage => :s3,
	 :bucket => 'tutorapp'
     #:s3_credentials => "#{Rails.root}/config/aws.yml"


	validates_attachment_presence :answer
	validates_attachment_content_type :answer, content_type: [ /\Aimage/, /pdf\Z/, 'application/pdf', 'application/force-download', 'application/msword', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document',"application/force-download","application/vnd.ms-excel", "application/vnd.openxmlformats-officedocument.wordprocessingml.document","application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", 
             "text/plain"],
             :message => "Only PDF, EXCEL, WORD, TEXT or Image(png, gif, jpeg) files are allowed."
    
										
end
