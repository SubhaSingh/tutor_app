class Assessment < ActiveRecord::Base
	belongs_to :course
	has_many :assessment_tutors, dependent: :destroy
	has_many :students, dependent: :destroy
	validates :name, presence: true, length: { maximum: 20 }
	validates :venue, presence: true, length: { maximum: 12 }
	validates :starttime, presence: true
	validates :user_id, presence: true
	validates :course_id, presence: true
	validates :date, presence: true
	default_scope -> { order(date: :desc) }


	def self.to_csv(assessment, options = {})
		CSV.generate(options) do |csv|
			csv << Student.column_names
			assessment.students.each do |row|
				csv << row.attributes.values
			end
		end
	end


end
