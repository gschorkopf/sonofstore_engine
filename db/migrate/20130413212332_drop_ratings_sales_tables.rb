class DropRatingsSalesTables < ActiveRecord::Migration
  def change
    drop_table :sales
    drop_table :ratings
  end
end
