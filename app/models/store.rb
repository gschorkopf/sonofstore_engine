class Store < ActiveRecord::Base
  attr_accessible :description, :name, :path, :active
  has_many :categories
  has_many :products

  validates :name, :uniqueness => { :case_sensitive => false }, :presence => true
  validates :path, :uniqueness => { :case_sensitive => false }, :presence => true
  validates :description, :presence => true
  
  def to_param
    path
  end

  def self.find(path)
    find_by_path(path)
  end

  def active?
    active == true
  end

  def approved?
    approval_status == 'approved'
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
end
