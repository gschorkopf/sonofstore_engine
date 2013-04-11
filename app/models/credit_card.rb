class CreditCard < ActiveRecord::Base
  attr_accessible :number, :expiration_month, :expiration_year, :security_code, :user_id

  belongs_to :user
  # attr_accessible :title, :body
end
