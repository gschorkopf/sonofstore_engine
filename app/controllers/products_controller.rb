class ProductsController < ApplicationController
  def index
    @products = current_store.products
    @categories = Category.all
  end

  def show
    session[:return_to] = request.fullpath
    @product = Product.find(params[:id])
  end
end
