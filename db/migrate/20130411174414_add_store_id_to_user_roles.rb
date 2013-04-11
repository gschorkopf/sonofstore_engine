class AddStoreIdToUserRoles < ActiveRecord::Migration
  def change
    add_column :user_roles, :store_id, :integer
  end
end
