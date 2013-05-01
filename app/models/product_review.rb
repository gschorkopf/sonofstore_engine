class ProductReview < ActiveRecord::Base

  attr_accessible :product_id, :customer_id, :comment, :featured, :status

  has_many :ratings, dependent: :destroy
  belongs_to :customer
  belongs_to :product

  validates :customer_id, presence: true
  #validate uniqueness of customer to the product (not store)
  validates :product_id, presence: true

  accepts_nested_attributes_for :ratings

  def self.make_new_product_review(prod_review_params, product_id, customer_id)
    product_review = ProductReview.new(prod_review_params)
    product_review.customer_id = customer_id
    product_review.product_id = product_id
    product_review
  end

  def display_name
    Customer.find(self.customer_id).best_display_name
  end
end
