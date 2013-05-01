class CreateRatingsTable < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.integer :question_id
      t.integer :rating
      t.integer :product_review_id
    end
    add_index :ratings, :product_review_id
    add_index :ratings, :question_id
  end
end
