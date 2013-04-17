class Checkout
  attr_reader :guest

  def initialize(params)
    @guest = Customer.find_by_email(params[:guest][:email])
    @guest ||= Customer.create(params[:guest])
    @shipping = params[:shipping_address]
    @billing = params[:billing_address]
    @credit_card = params[:credit_card]
  end

  def shipping
    new_shipping = ShippingAddress.new(@shipping)
    new_shipping.customer_id = @guest.id
    new_shipping.save
    new_shipping
  end

  def billing
    new_billing = BillingAddress.new(@billing)
    new_billing.customer_id = @guest.id
    new_billing.save
    new_billing
  end

  def credit_card
    new_credit_card = CreditCard.new(@credit_card)
    new_credit_card.customer_id = @guest.id
    new_credit_card.save
    new_credit_card
  end
end