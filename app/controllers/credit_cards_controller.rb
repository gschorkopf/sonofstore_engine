class CreditCardsController < ApplicationController
  before_filter :require_login

  def new
    @credit_card = CreditCard.new
  end

  def create
    @credit_card = CreditCard.new(params[:credit_card])

    if @credit_card.save
      if session[:return_to] == profile_url(current_user)
        redirect_to profile_path(current_user)
      else
        redirect_to new_user_order_path(current_user)
      end
    else
      render "new"
    end
  end

  def edit
    @credit_card = CreditCard.find_by_user_id(params[:user_id])
  end

  def update
    @credit_card = CreditCard.find_by_user_id(params[:user_id])
    if @credit_card.update_attributes(params[:credit_card])
      redirect_to profile_path,
        :notice  => "Successfully updated credit card information."
    else
      render :action => 'edit', :notice  => "Update failed."
    end
  end
end
