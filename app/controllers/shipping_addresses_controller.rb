class ShippingAddressesController < ApplicationController
  before_filter :require_login

  def new
    @shipping_address = ShippingAddress.new
    @customer = Customer.find_by_id(params[:customer_id])
  end

  def create
    @shipping_address = ShippingAddress.new(params[:shipping_address])
    if current_user
      @customer = current_user.customer
    else
      @customer = Customer.find_by_id(params[:customer_id])
    end
    @shipping_address.customer_id = @customer.id

    if @shipping_address.save
      if session[:return_to] == profile_url
        redirect_to profile_path
      else
        @customer.shipping_address_id = @shipping_address.id
        @customer.save
        redirect_to new_customer_billing_addresses_path(@customer)
      end
    else
      render "new"
    end
  end

  def edit
    @customer = current_user.customer
    @shipping_address = ShippingAddress.find_by_customer_id(@customer.id)
  end

  def update
    @customer = current_user.customer
    @shipping_address = ShippingAddress.find_by_customer_id(@customer.id)

    if @shipping_address.update_attributes(
                                      street_address: params[:street_address],
                                      city: params[:city],
                                      zip: params[:zip],
                                      state: params[:state]
                                      )
      redirect_to profile_path,
        :notice  => "Successfully updated shipping address."
    else
      redirect_to profile_path, :notice  => "Update failed."
    end
  end
end
