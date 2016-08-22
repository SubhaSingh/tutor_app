class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.references :course, foreign_key: true
      
      t.timestamps null: false
    end
  end
end
