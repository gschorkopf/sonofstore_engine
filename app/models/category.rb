class Category < ActiveRecord::Base
  attr_accessible :title, :product_ids, :store_id

  has_many :product_categories
  has_many :products, through: :product_categories
  belongs_to :store

  validates_uniqueness_of :title, scope: :store_id, :case_sensitive => false
  validates :title, presence: true
end
