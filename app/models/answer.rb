class Answer < ActiveRecord::Base
  
  attr_accessible :content
  
  belongs_to :question

  has_many :responses
  
end
