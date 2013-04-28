class Customer < ActiveRecord::Base
  attr_accessible :email, :full_name, :user

  has_one :user
  has_one :billing_address
  has_one :shipping_address
  has_one :credit_card
  has_many :orders
  has_many :product_reviews

  validates :full_name, presence: :true
  validates :email, presence: :true, uniqueness: { case_sensitive: false },
            format: { with: /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/ }

  accepts_nested_attributes_for :user


  def best_display_name
    #if customer has a user AND a display name, use it.
    if user && user.display_name
      user.display_name
    #otherwise, generate a random display name to use from a set
    else
      use_customer_initials
    end
  end

  def use_customer_initials
    initials = []

    full_name.split.each do |w|
      initials << w[0]
    end

    initials.join('.') + '.'
  end

  def has_purchased_product? product_id
    orders.joins(:order_items).where("order_items.product_id = ?", product_id).count > 0
  end
end
