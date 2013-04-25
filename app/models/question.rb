class Question < ActiveRecord::Base
  attr_accessible :question

  has_many :rating

  validates_presence_of :question

  def to_s
    question
  end
end
