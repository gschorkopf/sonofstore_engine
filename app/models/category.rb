class Category < ActiveRecord::Base
  attr_accessible :title, :product_ids, :store_id
  # has_and_belongs_to_many :products
  has_many :products
  belongs_to :store

  validates :title, presence: true
  validate :unique_category_title_in_store

  def unique_category_title_in_store
    if !store.categories.where("title ILIKE ?", "%#{title}%").empty?
      errors.add(:title,"This store can have only one category with this name")
    end
  end
end
