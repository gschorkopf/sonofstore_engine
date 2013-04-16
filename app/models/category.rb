class Category < ActiveRecord::Base
  attr_accessible :title, :product_ids, :store_id

  has_many :product_categories
  has_many :products, through: :product_categories
  belongs_to :store

  validates :title, presence: true
  validate :unique_category_title_in_store, on: :create
  validate :unique_category_title_in_store, on: :update
  validate :unique_category_title_in_store, on: :toggle_status

  def unique_category_title_in_store
    if !store.categories.where("title ILIKE ?", "%#{title}%").empty?
      errors.add(:title,"This store can have only one category with this name")
    end
  end
end
