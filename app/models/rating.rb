class Rating < ActiveRecord::Base
  attr_accessible :question_id, :rating, :product_review_id

  belongs_to :product_review
  belongs_to :question

  validates_presence_of :question_id, :rating, :product_review_id
end
