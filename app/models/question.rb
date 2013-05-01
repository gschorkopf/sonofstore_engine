class Question < ActiveRecord::Base
  attr_accessible :question, :long_form

  has_many :ratings
  has_many :product_reviews, through: :ratings
  has_many :products, through: :product_reviews

  validates_presence_of :question
  validates_presence_of :long_form

  def to_s
    question
  end
end
