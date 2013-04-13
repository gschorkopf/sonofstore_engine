class CreateCustomersTable < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :email
      t.string :full_name
      t.references :shipping_address
      t.references :billing_address
      t.references :credit_card
    end
  end
end
