class AddAnswerToSolutions < ActiveRecord::Migration
  def self.up
  	add_attachment :solutions, :answer
  end

  def self.down
    remove_attachment :solutions, :answer
  end
end
