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

  def self.create_and_charge(params)
    order = create(status: 'pending', user_id: params[:user].id)

    params[:cart].items.each do |cart_item|
      order.order_items.create(product_id: cart_item.product.id,
                               unit_price: cart_item.unit_price,
                               selling_price: cart_item.selling_price,
                               quantity: cart_item.quantity)
    end

    order
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
