class Category < ActiveRecord::Base
  attr_accessible :title, :product_ids, :store_id
  has_and_belongs_to_many :products

  validates :title, presence: true
  validate :unique_category_title_in_store, on: :create

  def unique_category_title_in_store
    store = Store.find_by_id(store_id)
    if !store.categories.where("title ILIKE ?", "%#{title}%").empty?
      errors.add(:title,"This store can have only one category with this name")
    end
  end
  #UNTESTED
end