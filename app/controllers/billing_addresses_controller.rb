class BillingAddressesController < ApplicationController
  before_filter :require_login

  def new
    @billing_address = BillingAddress.new
  end

  def create
    @billing_address = BillingAddress.new(params[:billing_address])

    if @billing_address.save
      redirect_to root_url
    else
      render "new"
    end
  end
end
