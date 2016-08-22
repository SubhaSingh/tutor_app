class Students < ActiveRecord::Migration
  def change
  	  create_table :students do |t|
      t.string :name
      t.string :student_number
      t.boolean :attendance, default: false
      t.boolean :task_completed, default: false
      t.decimal :mark, :precision => 5, :scale => 2, default: 0
      t.references :assessment, foreign_key: true
      t.references :user, foreign_key: true #User who edited student record
      t.timestamps null: false
    end
    add_index :students, [:student_number]
  end
 
end
