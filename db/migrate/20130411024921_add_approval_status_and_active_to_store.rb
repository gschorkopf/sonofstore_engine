class AddApprovalStatusAndActiveToStore < ActiveRecord::Migration
  def change
    add_column :stores, :approval_status, :string, default: 'pending'
    add_column :stores, :active, :boolean, default: false
  end
end
