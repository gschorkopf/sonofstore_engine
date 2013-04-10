class ProductsController < ApplicationController

  def index
    @products = current_store.products
    @categories = current_store.categories
  end

  def show
    session[:return_to] = request.fullpath
    @product = Product.find(params[:id])
  end
end
