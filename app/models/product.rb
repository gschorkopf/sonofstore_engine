class Product < ActiveRecord::Base
  attr_accessible :title, :description, :price,
                  :status, :category_ids, :image, :store_id

  belongs_to :store

  has_many :product_reviews
  has_many :product_categories
  has_many :categories, through: :product_categories

  has_attached_file :image, styles: { retail: "500x500",
                                      large: "500x500",
                                      thumbnail: "200x200" },
                            storage: :s3,
                            bucket: 'c3po_store_engine',
                            path: ":attachment/:id/:style.:extension",
                            s3_credentials: {
                              access_key_id: ENV['AWS_ACCESS_KEY_ID'],
                              secret_access_key: ENV['AWS_SECRET_ACCESS_KEY']
                              }

  validates :title, presence: :true
  validate :unique_product_title_in_store
  validates :description, presence: :true
  validates :store_id, presence: :true
  validates :status, presence: :true,
                     inclusion: { in: %w(active retired) }
  validates :price, presence: :true,
                    format: { with: /^\d+??(?:\.\d{0,2})?$/ },
                    numericality: { greater_than: 0 }


  def unique_product_title_in_store
    if exists_in_store?(title, id, store_id)
      errors.add(:title,"This store can have only one product with this name")
    end
  end

  def exists_in_store?(title, id, store_id)
    if id && store_id
      !Store.find_by_id(store_id).products.where("title ILIKE ?", "%#{title}%").
                      where("id <> ?", id).empty?
    elsif store_id
      !Store.find_by_id(store_id).products.where("title ILIKE ?", "%#{title}%")
    else
      errors.add(:base, "Not valid without a store id")
    end
  end

  def toggle_status
    if status == 'active'
      update_attributes(status: 'retired')
    elsif status == 'retired'
      update_attributes(status: 'active')
    end
  end

  def current_price
    price
  end

  def most_recent_reviews
    product_reviews.order("updated_at DESC")
  end
end
