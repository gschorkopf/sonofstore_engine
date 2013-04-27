class Store < ActiveRecord::Base
  attr_accessible :description, :name, :path, :active
  has_many :categories
  has_many :products

  has_many :user_roles
  has_many :users, through: :user_roles

  validate :unique_name_among_approved_stores
  validate :unique_path_among_approved_stores

  validates :name, :presence => true
  validates :path, :presence => true,
            format: { with: /\A[A-Za-z0-9-]+\z/ }
  validates :description, :presence => true

  def to_param
    path
  end

  def unique_name_among_approved_stores
    if Store.exists_with_name?(name, id)
      errors.add(:name, "already exists")
    end
  end

  def unique_path_among_approved_stores
    if Store.exists_with_path?(path, id)
      errors.add(:path, "already exists")
    end
  end

  def self.exists_with_name?(name, id)
    if id
      !Store.approved.where("name ILIKE ?", "%#{name}%").where("id <> ?", id).empty?
    else
      !Store.approved.where("name ILIKE ?", "%#{name}%").empty?
    end
  end

  def self.exists_with_path?(path, id)
    if id
      !Store.approved.where("path ILIKE ?", "%#{path}%").where("id <> ?", id).empty?
    else
      !Store.approved.where("path ILIKE ?", "%#{path}%").empty?
    end
  end

  def self.find(path)
    find_by_path(path)
  end

  def active?
    active == true
  end

  def self.approved
    where(:approval_status => 'approved')
  end

  def approved?
    approval_status == 'approved'
  end

  def to_s
    name
  end

  def active_to_s
    if active?
      "Enabled"
    else
      "Disabled"
    end
  end

  def pending?
    approval_status == 'pending'
  end

  def toggle_active
    if active?
      update_attributes(active: false)
    else
      update_attributes(active: true)
    end
  end

  def filter_products_by_category(category_id)
    categories.find(category_id).products
  end

  def top_products
    products[0..3]
  end
end
