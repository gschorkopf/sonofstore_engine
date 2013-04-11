class ShippingAddressesController < ApplicationController
  before_filter :require_login

  def new
    @shipping_address = ShippingAddress.new
  end

  def create
    @shipping_address = ShippingAddress.new(params[:shipping_address])

    if @shipping_address.save
      redirect_to new_user_billing_addresses_path(current_user)
    else
      render "new"
    end
  end
end
