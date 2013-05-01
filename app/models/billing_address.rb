class BillingAddress < ActiveRecord::Base
  attr_accessible :street_address, :city, :zip, :state, :customer_id

  validates_presence_of :street_address, :city, :zip, :state

  validates :zip,
            :length => {:minimum => 5, :maximum => 5},
            :numericality => true

  belongs_to :customer
end
