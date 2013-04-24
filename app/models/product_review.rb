class ProductReview < ActiveRecord::Base

  attr_accessible :product_id, :customer_id, :comment

  has_one :rating
  belongs_to :customer
  belongs_to :product

  validates :customer_id, presence: true
  #validate uniqueness of customer to the product (not store)
  validates :product_id, presence: true
end
