class ShippingAddressesController < ApplicationController
  before_filter :require_login

  def new
    @shipping_address = ShippingAddress.new
  end

  def create
    @shipping_address = ShippingAddress.new(params[:shipping_address])

    @shipping_address.user_id = current_user

    if @shipping_address.save
      redirect_to root_url
    else
      render "new"
    end
  end
end
