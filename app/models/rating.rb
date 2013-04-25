class Rating < ActiveRecord::Base
  attr_accessible :question_id, :rating, :product_review_id

  belongs_to :product_review
  belongs_to :question

  validates_presence_of :question_id, :rating, :product_review_id


  def self.make_new_ratings(ratings, product_review_id)
    #params is an arrah of hashes
    new_ratings = ratings.collect do |rating|
      Rating.new(question_id: rating[:question_id],
                  rating: rating[:rating],
                  product_review_id: product_review_id)
    end

    if new_ratings.any?{ |rating| rating.invalid? }
      false
    else
      new_ratings.each(&:save)
    end
  end
end
