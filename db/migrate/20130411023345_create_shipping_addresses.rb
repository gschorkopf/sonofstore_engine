class CreateShippingAddresses < ActiveRecord::Migration
  def change
    create_table :shipping_addresses do |t|
      t.string :street_address
      t.string :city
      t.string :zip
      t.string :state
      t.references :user

      t.timestamps
    end
    add_index :shipping_addresses, :user_id
  end
end
