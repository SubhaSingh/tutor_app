class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.string :role
      t.decimal :clarity, :precision => 4, :scale => 2, default: 0
      t.decimal :conciseness, :precision => 4, :scale => 2, default: 0
      t.decimal :familiarity, :precision => 4, :scale => 2, default: 0
      t.decimal :responsiveness, :precision => 4, :scale => 2, default: 0
      t.decimal :consistency, :precision => 4, :scale => 2, default: 0
      t.decimal :attractiveness, :precision => 4, :scale => 2, default: 0
      t.decimal :efficiency, :precision => 4, :scale => 2, default: 0
      t.decimal :forgiving, :precision => 4, :scale => 2, default: 0
      t.decimal :informativeness, :precision => 4, :scale => 2, default: 0
      t.decimal :devices, :precision => 4, :scale => 2, default: 0
      t.text :comments
      t.timestamps null: false
    end
  end
end
