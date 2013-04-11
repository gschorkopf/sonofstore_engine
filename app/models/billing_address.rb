class BillingAddress < ActiveRecord::Base
  attr_accessible :street_address, :city, :zip, :state, :user_id

  validates_presence_of :street_address, :city, :zip, :state

  belongs_to :user
  # attr_accessible :title, :body
end
