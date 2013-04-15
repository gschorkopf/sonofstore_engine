class User < ActiveRecord::Base
  authenticates_with_sorcery!
  attr_accessible :display_name, :password, :password_confirmation, :customer_id

  validates_confirmation_of :password,
                            message: "passwords did not match", if: :password
  validates_presence_of :password, :on => :create
  validates_presence_of :customer_id, :on => :create

  validates :display_name, length: { in: 2..32 }, allow_blank: :true

  has_many :user_roles
  has_many :stores, through: :user_roles

  belongs_to :customer

  def default_values
    self.admin = false
  end

  def to_s
    customer.full_name
  end

  def self.email(email)
    customer = Customer.find_by_email("#{email}")
    user = User.find_by_customer_id(customer.id)
  end

  def role_for_store?(role, store)
    selected_store = self.stores.where(id: store.id).first

    if selected_store
      selected_user_roles = self.user_roles.where(store_id: selected_store.id)
      selected_user_roles.any? {|ur| ur.role == role }
    else
      false
    end
  end
end
