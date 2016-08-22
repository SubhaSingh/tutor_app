class CreateAssessmentTutors < ActiveRecord::Migration
  def change
    create_table :assessment_tutors do |t|
    	t.references :user, foreign_key: true
    	t.references :assessment, foreign_key: true
      	t.timestamps null: false
    end

  end
end
