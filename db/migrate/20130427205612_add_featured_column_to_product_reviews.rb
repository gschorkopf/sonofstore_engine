class AddFeaturedColumnToProductReviews < ActiveRecord::Migration
  def change
    add_column :product_reviews, :featured, :boolean, :default => false , :null => false
  end
end
