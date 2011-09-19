class Survey < ActiveRecord::Base
  
  attr_accessible :name, :description, :questions_attributes
  
  has_many :questions, :dependent => :destroy
  
  belongs_to :user
  
  validates :name, :presence => true
  validates :description, :presence => true
  validates :user_id, :presence => true
  
  accepts_nested_attributes_for :questions, :reject_if => lambda { |a| a[:content].blank? }, 
                                            :allow_destroy => true
end
