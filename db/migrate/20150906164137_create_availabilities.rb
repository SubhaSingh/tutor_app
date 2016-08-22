class CreateAvailabilities < ActiveRecord::Migration
  def change
    create_table :availabilities do |t|
   	   t.references :course, foreign_key: true

      t.timestamps null: false
    end
  end
end
