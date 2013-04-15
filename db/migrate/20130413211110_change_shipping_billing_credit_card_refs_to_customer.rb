class ChangeShippingBillingCreditCardRefsToCustomer < ActiveRecord::Migration
  def change
    remove_column :shipping_addresses, :user_id
    remove_column :billing_addresses, :user_id
    remove_column :credit_cards, :user_id

    add_column :credit_cards, :customer_id, :integer
    add_column :shipping_addresses, :customer_id, :integer
    add_column :billing_addresses, :customer_id, :integer

    add_index :billing_addresses, :customer_id
    add_index :shipping_addresses, :customer_id
    add_index :credit_cards, :customer_id
  end
end
