class Question < ActiveRecord::Base
  attr_accessible :question

  has_many :rating

  validates_presence_of :question
end
