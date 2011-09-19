class AddInfoToQuestions < ActiveRecord::Migration
  def self.up
    add_column :questions, :question_order, :integer
  end

  def self.down
    remove_column :questions, :question_order
  end
end