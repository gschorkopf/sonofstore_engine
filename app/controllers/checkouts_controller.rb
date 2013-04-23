class CheckoutsController < ApplicationController

  def create
    @checkout = Checkout.new(params)
    @customer = @checkout.guest
    @customer.shipping_address_id = @checkout.shipping
    @customer.billing_address_id = @checkout.billing
    @customer.credit_card_id = @checkout.credit_card
    @customer.save
    redirect_to store_new_order_path(current_store, @customer.id)
  end
end
