class CreateAssessments < ActiveRecord::Migration
  def change
    create_table :assessments do |t|
      t.string :name
      t.string :venue
      t.datetime :starttime
      t.datetime :endtime
      t.date :date
      t.text :notes
      t.references :user, foreign_key:true
      t.references :course, foreign_key: true

      t.timestamps null: false
    end
    add_index :assessments, [:created_at]
  end
end
