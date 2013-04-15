class AddHashToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :uuid_hash, :string
  end
end
