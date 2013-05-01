class AddStatusColumnToProductReviewsTable < ActiveRecord::Migration
  def change
    add_column :product_reviews, :status, :string, :default => 'active'
  end
end
