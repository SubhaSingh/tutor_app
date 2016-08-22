class CreateSolutions < ActiveRecord::Migration
  def change
    create_table :solutions do |t|
    	t.references :course, foreign_key: true
      	t.timestamps null: false
      	t.references :user, foreign_key: true
    end
    add_index :solutions, [:created_at]
  end
end
