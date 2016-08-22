class CreateConvenors < ActiveRecord::Migration
  def change
    create_table :convenors do |t|
      t.references :course, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps null: false
    end
  end
end
