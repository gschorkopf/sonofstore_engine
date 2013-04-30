class Category < ActiveRecord::Base
  attr_accessible :title, :product_ids, :store_id

  has_many :product_categories
  has_many :products, through: :product_categories
  belongs_to :store

  validates_uniqueness_of :title, scope: :store_id, :case_sensitive => false
  validates :title, presence: true
  # validate :unique_category_title_in_store

  # def unique_category_title_in_store
  #   if exists_in_store?(title, id, store_id)
  #     errors.add(:title,
  #  "This store can have only one category with this name")
  #   end
  # end

  # def exists_in_store?(title, id, store_id)
  #   !Store.find_by_id(store_id).categories.
  #      where("title ILIKE ?", "%#{title}%").empty?
  # end
end
