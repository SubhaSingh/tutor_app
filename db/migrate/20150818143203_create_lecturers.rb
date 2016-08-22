class CreateLecturers < ActiveRecord::Migration
  def change
    create_table :lecturers do |t|
      t.references :course, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps null: false
    end
  end
end
