class ProductReview < ActiveRecord::Base

  attr_accessible :product_id, :customer_id, :comment, :featured

  has_many :ratings, dependent: :destroy
  belongs_to :customer
  belongs_to :product

  validates :customer_id, presence: true
  #validate uniqueness of customer to the product (not store)
  validates :product_id, presence: true

  accepts_nested_attributes_for :ratings
end
