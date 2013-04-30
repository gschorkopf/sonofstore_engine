class BillingAddressesController < ApplicationController
  before_filter :require_login

  def edit
    @customer = current_user.customer
    @billing_address = BillingAddress.find_by_customer_id(@customer.id)
  end

  def update
    @customer = current_user.customer
    @billing_address = BillingAddress.find_by_customer_id(@customer.id)
    params.delete("utf8")
    params.delete("_method")
    params.delete("authenticity_token")
    params.delete("controller")
    params.delete("commit")
    params.delete("action")

    if @billing_address.update_attributes(params)
      redirect_to profile_path,
        :notice  => "Successfully updated billing address."
    else
      rendirect_to profile_path, :notice  => "Update failed."
    end
  end
end
