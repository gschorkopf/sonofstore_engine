class CustomersController < ApplicationController

  def create
    @customer = Customer.new(params[:customer])

    if @customer.save
      redirect_to new_customer_shipping_addresses_path
    else
      YOU FUCKED UP!
    end
  end

  def new
    @customer = Customer.new
  end

  def update
   @customer = current_user.customer
    if @customer.update_attributes(params[:customer])
      redirect_to account_profile_path,
      :notice => "Successfully updated account"
    else
      render :action => 'show'
    end
  end
end
