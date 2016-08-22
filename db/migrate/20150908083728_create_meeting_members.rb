class CreateMeetingMembers < ActiveRecord::Migration
  def change
    create_table :meeting_members do |t|
    	t.references :user, foreign_key: true
    	t.references :meeting, foreign_key: true
      	t.timestamps null: false
    end
  end
end
