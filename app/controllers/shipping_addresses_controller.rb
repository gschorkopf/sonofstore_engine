class ShippingAddressesController < ApplicationController
  before_filter :require_login

  def edit
    @customer = current_user.customer
    @shipping_address = ShippingAddress.find_by_customer_id(@customer.id)
  end

  def update
    @customer = current_user.customer
    @shipping_address = ShippingAddress.find_by_customer_id(@customer.id)
    params.delete("utf8")
    params.delete("_method")
    params.delete("authenticity_token")
    params.delete("controller")
    params.delete("commit")
    params.delete("action")
    if @shipping_address.update_attributes(params)
      redirect_to profile_path,
        :notice  => "Successfully updated shipping address."
    else
      redirect_to profile_path, :notice  => "Update failed."
    end
  end
end
