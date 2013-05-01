class Order < ActiveRecord::Base
  attr_accessible :status, :customer_id

  belongs_to :customer
  has_many :order_items, dependent: :destroy
  has_many :products, through: :order_items

  validates :customer_id, presence: true
  validates :status, presence: true,
                    inclusion: {in: %w(pending cancelled paid shipped returned),
                                  message: "%{value} is not a valid status" }

  scope :by_email, lambda {|email| where("email = ?", email) if email.present?}

  def self.by_status(status)
    if status.present? && status != 'all'
      order.where(status: status)
    else
      scoped
    end
  end

  DEFAULT_STATUS = 'pending'

  def self.generate_new_order(store_id, customer_id, current_session_cart)
    order = Order.new(customer_id: customer_id, status: DEFAULT_STATUS)
    order.store_id, order.uuid_hash = store_id, UUID.new.generate
    order.save
    order.create_order_items(current_session_cart)
    order
  end

  def create_order_items(current_session_cart)
    current_session_cart.each do |product_id, quantity|
      product = Product.find(product_id)
      self.order_items.create(  product_id: product.id,
                                unit_price: product.price,
                                quantity: quantity  )
    end
  end

  def update_status
    next_status = { 'pending' => 'cancelled',
                    'paid' => 'shipped',
                    'shipped' => 'returned' }
    self.status = next_status[self.status]
    self.save
  end

  def total
    if order_items.present?
      order_items.map {|order_item| order_item.subtotal }.inject(&:+)
    else
      0
    end
  end

  def value
    total
  end
end
