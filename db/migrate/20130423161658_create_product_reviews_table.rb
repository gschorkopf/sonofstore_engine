class CreateProductReviewsTable < ActiveRecord::Migration
  def change
    create_table :product_reviews do |t|
      t.integer :product_id
      t.integer :customer_id
      t.string :comment, :limit => 500
      t.timestamps
    end
    add_index :product_reviews, :product_id
  end
end
