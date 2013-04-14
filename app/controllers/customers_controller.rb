class CustomersController < ApplicationController

  def create

  end

  def new

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
