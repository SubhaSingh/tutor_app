class Student < ActiveRecord::Base
	
	require 'csv'
	belongs_to :assessment
	validates :name, presence: true
	validates :student_number, presence: true
	validates :assessment_id, presence: true
	validates :user_id, presence: true
	default_scope -> { order(id: :asc) }

	def self.import(file, assessment, current_user)		

		 CSV.foreach(file.path, {:headers => true}) do |row|
		
			student_hash = { :name => row[0], :student_number => row[1], assessment_id: assessment.id, :user_id => current_user.id}	
			#Checks if there is a record already in the database with the same student number and assessment id		
			student = Student.where(student_number: student_hash[:student_number], assessment_id: student_hash[:assessment_id])
		
			if student.count == 1
				student.update_all(student_hash)

			else
				Student.create!(student_hash)
			end
	
		end
	end

end
