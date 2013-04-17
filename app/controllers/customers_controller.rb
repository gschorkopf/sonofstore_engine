class CustomersController < ApplicationController

  def create
    @customer = Customer.find_or_create_by_email(params[:customer][:email])

    if @customer
      if current_user
        redirect_to session[:return_to] || profile_path, notice: 'Logged in!'
      else
        redirect_to new_customer_shipping_addresses_path(@customer.id)
      end
    else
      redirect_to guest_checkout_path, notice: "Invalid credentials"
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
