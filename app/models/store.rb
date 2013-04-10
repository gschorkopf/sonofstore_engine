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

end
