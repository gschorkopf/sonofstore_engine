class CreditCardsController < ApplicationController
  before_filter :require_login

  def edit
    @customer = current_user.customer
    @credit_card = CreditCard.find_by_customer_id(@customer.id)
  end

  def update
    @customer = current_user.customer
    @credit_card = CreditCard.find_by_customer_id(@customer.id)
    params.delete("utf8")
    params.delete("_method")
    params.delete("authenticity_token")
    params.delete("controller")
    params.delete("commit")
    params.delete("action")
    if @credit_card.update_attributes(params)
      @credit_card.customer_id = @customer.id
      redirect_to profile_path,
        :notice  => "Successfully updated credit card information."
    else
      redirect_to profile_path, :notice  => "Update failed."
    end
  end
end
