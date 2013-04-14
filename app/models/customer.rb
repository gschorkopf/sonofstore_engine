class Customer < ActiveRecord::Base
  attr_accessible :email, :full_name, :user

  has_one :user
  has_one :billing_address
  has_one :shipping_address
  has_one :credit_card
  has_many :orders

  validates :full_name, presence: :true
  # validates :email, presence: :true, uniqueness: { case_sensitive: false },
  #           format: { with: /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/ }

  accepts_nested_attributes_for :user
end
