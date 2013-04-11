class CartsController < ApplicationController
  before_filter :find_or_create_cart

  def show
    session[:return_to] = request.fullpath
  end

  def update
    session[:cart] = current_cart.update(params[:carts])
    # current_cart.session.delete_if {|key, value| value == 0}
    #current_cart.items.reject!{|cart_item| cart_item.quantity.to_i == 0}
    # session[:cart] = current_cart.update(current_cart.items.reject do |cart_item|
    #   cart_item.quantity == 0
    # end)
    redirect_to(:back)
  end

  def remove_item
    session[:cart] = current_cart.remove_item(params[:remove_item])
    redirect_to(:back)
  end

  def destroy
    session[:cart] = current_cart.destroy
    redirect_to root_path, :notice  => "Cart cleared."
  end
end
