class BillingAddressesController < ApplicationController
  before_filter :require_login

  def new
    @billing_address = BillingAddress.new
    if current_user
      @customer = current_user.customer
    end
  end

  def create
    @billing_address = BillingAddress.new(params[:billing_address])
    if current_user
      @customer = current_user.customer
    else
      @customer = Customer.find_by_id(params[:customer_id])
    end
    @billing_address.customer_id = @customer.id
    if @billing_address.save
      if session[:return_to] == profile_url
        redirect_to profile_path
      else
        @customer.billing_address_id = @billing_address.id
        @customer.save
        redirect_to new_customer_credit_cards_path(@customer)
      end
    else
      render "new"
    end
  end

  def edit
    @customer = current_user.customer
    @billing_address = BillingAddress.find_by_customer_id(@customer.id)

  end

  def update
    @customer = current_user.customer
    @billing_address = BillingAddress.find_by_customer_id(@customer.id)

    if @billing_address.update_attributes(
                                      street_address: params[:street_address],
                                      city: params[:city],
                                      zip: params[:zip],
                                      state: params[:state]
                                      )
      redirect_to profile_path,
        :notice  => "Successfully updated billing address."
    else
      redirect_to profile_path, :notice  => "Update failed."
    end
  end
end
