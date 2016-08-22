class CreateMeetings < ActiveRecord::Migration
  def change
    create_table :meetings do |t|
    	t.string :name
    	t.string :venue
    	t.datetime :starttime
      t.datetime :endtime
      t.date :date
      t.text :notes
   		t.references :course, foreign_key: true
      t.references :user, foreign_key: true
      t.timestamps null: false
    end
    add_index :meetings, [:created_at]
  end
end
