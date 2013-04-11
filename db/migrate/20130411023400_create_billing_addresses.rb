class CreateBillingAddresses < ActiveRecord::Migration
  def change
    create_table :billing_addresses do |t|
      t.string :street_address
      t.string :city
      t.string :zip
      t.string :state
      t.references :user

      t.timestamps
    end
    add_index :billing_addresses, :user_id
  end
end
