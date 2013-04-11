class BillingAddressesController < ApplicationController
  before_filter :require_login

  def new
    @billing_address = BillingAddress.new
  end

  def create
    @billing_address = BillingAddress.new(params[:billing_address])

    if @billing_address.save
      redirect_to new_user_credit_cards_path(current_user)
    else
      render "new"
    end
  end

  def edit
    @billing_address = BillingAddress.find_by_user_id(current_user.id)
  end

  def update
    @billing_address = BillingAddress.find_by_user_id(current_user.id)

    if @billing_address.update_attributes(params[:billing_address])
      redirect_to account_profile_path,
        :notice  => "Successfully updated billing address."
    else
      render :action => 'edit', :notice  => "Update failed."
    end
  end
end
