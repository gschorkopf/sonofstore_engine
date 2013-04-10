class ChangeAdminColumnName < ActiveRecord::Migration
  def change
    rename_column :users, :admin, :platform_admin
  end
end
