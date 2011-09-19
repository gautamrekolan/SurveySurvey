class Response < ActiveRecord::Base
  
  validates_presence_of :answer_id, :question_id, :user_id

  belongs_to :answer
  belongs_to :question
  belongs_to :user
  
end
