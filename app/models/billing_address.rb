class BillingAddress < ActiveRecord::Base
  attr_accessible :street_address, :city, :zip, :state, :user_id

  belongs_to :user
  # attr_accessible :title, :body
end
