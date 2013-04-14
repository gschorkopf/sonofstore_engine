class CustomersController < ApplicationController

  def create
    @customer = Customer.new(email: params[:customer][:email], full_name: params[:customer][:full_name])

    if @customer.save
      if params[:customer][:users]
        display_name = params[:customer][:users][:display_name]
        password = params[:customer][:users][:password]
        #password_confirmation =
        @user = User.create(display_name: display_name, password: password, customer_id: @customer.id)
        auto_login(@user)
      end



      redirect_to new_customer_shipping_addresses_path(@customer.id)
    else
      YOU FUCKED UP!
    end
  end

  def new
    @customer = Customer.new
  end

  def signup
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
