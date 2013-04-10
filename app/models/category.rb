class Category < ActiveRecord::Base
  attr_accessible :title, :product_ids, :store_id
  has_and_belongs_to_many :products

  validates :title, presence: true
  validate :unique_category_name_in_store


  def unique_category_name_in_store
    store = Store.find_by_id(store_id)
    if store.categories.find_by_title(title)
      errors.add(:title,"This store can have only one category with this name")
    end
  end
  # CASE SENSITIVITY AINT HERE
end
