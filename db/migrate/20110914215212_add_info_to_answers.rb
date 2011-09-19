class AddInfoToAnswers < ActiveRecord::Migration
  def self.up
    add_column :answers, :answer_index, :integer
  end

  def self.down
    drop_column :answers, :answer_index
  end
end
