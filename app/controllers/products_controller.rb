class ProductsController < ApplicationController

  def index
    if current_store.pending?
      redirect_to root_path, alert: "The store you are looking for does not exist."
      return
    elsif current_store.active == false && current_store.approved?
      redirect_to root_path, alert: "#{current_store.name} is currently under construction. Thank you for your patience."
      return
    elsif current_store.approved?
      @products = current_store.products
      @categories = current_store.categories
    else
      redirect_to root_path, alert: "The store you are looking for does not exist."
      return
    end
  end

  def show
    session[:return_to] = request.fullpath
    @product = Product.find(params[:id])
  end
end
