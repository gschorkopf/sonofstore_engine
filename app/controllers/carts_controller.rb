class CartsController < ApplicationController
  before_filter :find_or_create_cart

  def show
    session[:return_to] = request.fullpath
  end

  def update
    @store = current_store
    session[:cart] = current_cart(@store).update(params[:carts])
    redirect_to(:back)
  end

  def remove_item
    @store = current_store
    session[:cart] = current_cart(@store).remove_item(params[:remove_item])
    redirect_to(:back)
  end

  def destroy
    @store = current_store
    session[:cart] = current_cart(@store).destroy
    redirect_to root_path, :notice  => "Cart cleared."
  end
end
