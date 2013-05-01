class CreditCardsController < ApplicationController
  before_filter :require_login

  def new
    @credit_card = CreditCard.new
  end

  def create
    @credit_card = CreditCard.new(params[:credit_card])
    if current_user
      @customer = current_user.customer
    else
      @customer = Customer.find_by_id(params[:customer_id])
    end
    @credit_card.customer_id = @customer.id
    if @credit_card.save
      if session[:return_to] == profile_url
        redirect_to profile_path
      else
        @customer.credit_card_id = @credit_card.id
        @customer.save
        redirect_to new_store_order_path(current_store)
      end
    else
      render "new"
    end
  end

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
