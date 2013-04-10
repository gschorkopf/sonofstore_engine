class UserRole < ActiveRecord::Base
  attr_accessible :user_id
  has_one :users
  #has_many :stores

  ROLES = %w[store_admin stocker]

  def role_symbols
    [role.to_sym]
  end
end
