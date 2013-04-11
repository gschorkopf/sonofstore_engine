class Store < ActiveRecord::Base
  attr_accessible :description, :name, :path
  has_many :categories
  has_many :products

  validates :name, :uniqueness => { :case_sensitive => false }
  validates :path, :uniqueness => { :case_sensitive => false }
  
  def to_param
    path
  end

  def self.find(path)
    find_by_path(path)
  end
  
  def to_s
    name
  end

  def pending?
    approval_status == 'pending'
  end

  def toggle_active
    if status == 'enabled'
      update_attributes(status: 'retired')
    elsif status == 'disabled'
      update_attributes(status: 'active')
    end
  end
end
