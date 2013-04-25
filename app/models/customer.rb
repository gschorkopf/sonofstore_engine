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
      generate_random_display_name
    end
  end

  def generate_random_display_name
    [
      'A Loyal Customer',
      'Sir Shops-A-Lot',
      'Pink Princess 2008',
      'PUnKGuRl440',
      'MonsterCars2006'
    ].sample
  end
end
