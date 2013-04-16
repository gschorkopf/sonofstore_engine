class CartsController < ApplicationController
  before_filter :find_or_create_store_cart

  def show
    session[:return_to] = request.fullpath
  end

  def update
    session[current_store.path] = current_cart.update(params[:carts])
    redirect_to(:back)
  end

  def remove_item
    session[current_store.path] = current_cart.remove_item(params[:remove_item])
    redirect_to(:back)
  end

  def destroy
    session[current_store.path] = current_cart.destroy
    redirect_to store_home_path(current_store), :notice  => "Cart cleared."
  end
end
