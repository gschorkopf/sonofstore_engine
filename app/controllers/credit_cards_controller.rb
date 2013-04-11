class CreditCardsController < ApplicationController
  before_filter :require_login

  def new
    @credit_card = CreditCard.new
  end

  def create
    @credit_card = CreditCard.new(params[:credit_card])

    if @credit_card.save
      redirect_to user_orders_path(current_user)
    else
      render "new"
    end
  end
end
