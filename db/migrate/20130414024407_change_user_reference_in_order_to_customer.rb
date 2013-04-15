class ChangeUserReferenceInOrderToCustomer < ActiveRecord::Migration
  def change
    remove_column :orders, :user_id

    add_column :orders, :customer_id, :integer
    add_index :orders, :customer_id
  end
end
