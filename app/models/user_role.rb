class UserRole < ActiveRecord::Base
  attr_accessible :user_id, :store_id
  # has_one :user
  belongs_to :user
  belongs_to :store

  ROLES = %w[store_admin stocker]

  def role_symbols
    [role.to_sym]
  end

  def role?(role)
    self.role == role.to_s
  end
end
