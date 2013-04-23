class UserRole < ActiveRecord::Base
  attr_accessible :user_id, :store_id

  belongs_to :user
  belongs_to :store

  ROLES = %w[store_admin stocker]

  def role_symbols
    [role.to_sym]
  end
end
