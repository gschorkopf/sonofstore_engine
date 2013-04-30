class Question < ActiveRecord::Base
  attr_accessible :question, :long_form

  has_many :rating

  validates_presence_of :question
  validates_presence_of :long_form

  def to_s
    question
  end
end
