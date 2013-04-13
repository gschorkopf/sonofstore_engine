class ShippingAddressesController < ApplicationController
  before_filter :require_login

  def new
    @shipping_address = ShippingAddress.new
  end

  def create
    @shipping_address = ShippingAddress.new(params[:shipping_address])

    if @shipping_address.save
      if session[:return_to] == profile_url(current_user)
        redirect_to profile_path(current_user)
      else
        redirect_to new_user_billing_addresses_path(current_user)
      end
    else
      render "new"
    end
  end

  def edit
    @shipping_address = ShippingAddress.find_by_user_id(params[:user_id])
    # @shipping_address = current_user.create_shipping_address street_address: "something",
    #   city: "city", state: "state", zip: "zip"

    # raise @shipping_address.inspect
  end

  def update
    @shipping_address = ShippingAddress.find_by_user_id(params[:user_id])
    if @shipping_address.update_attributes(params[:shipping_address])
      redirect_to profile_path,
        :notice  => "Successfully updated shipping address."
    else
      render :action => 'edit', :notice  => "Update failed."
    end
  end
end
