class Category < ActiveRecord::Base
  attr_accessible :title, :product_ids, :store_id
  # has_and_belongs_to_many :products
  has_many :products
  belongs_to :store

  validates :title, presence: true
  validate :unique_category_name_in_store


  def unique_category_name_in_store
    existing_category = store.categories.find_by_title(title)
    if existing_category && existing_category.id != id
      errors.add(:title,"This store can have only one category with this name")
    end
  end
  # CASE SENSITIVITY AINT HERE
end
