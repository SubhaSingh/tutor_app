class CreateTutorInformations < ActiveRecord::Migration
  def change
    create_table :tutor_informations do |t|
      t.text :content
      t.references :user, index: true, foreign_key: true
      t.references :course, foreign_key: true

      t.timestamps null: false
    end
  end
end
