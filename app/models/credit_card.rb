class CreditCard < ActiveRecord::Base
  attr_accessible :number, :expiration_month,
                  :expiration_year, :security_code, :customer_id

  validates_presence_of :number,
                        :expiration_month,
                        :expiration_year,
                        :security_code,
                        :customer_id

  validates :number, :length => { :minimum => 16, :maximum => 16,
             message: "Credit card number must be 16 digits" },
            :numericality => true

  validates :security_code, :length => { :minimum => 3, :maximum => 3,
             message: "Security code must be three digits" },
            :numericality => true

  validates :expiration_month,
            :numericality => { :only_integer => true,
                               :greater_than => 0,
                               :less_than_or_equal_to => 12
                             }

  validates :expiration_year,
            :length => { :minimum => 2, :maximum => 4,
message: "Please submit in four digit format - example: 2013 or two-digit 13" },
            :numericality => true

  belongs_to :customer
end
