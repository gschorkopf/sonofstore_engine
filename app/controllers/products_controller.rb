class ProductsController < ApplicationController

  def index
    if current_store
      if current_store.pending?
        redirect_to root_path,
                        alert: "The store you are looking for does not exist."
        return
      elsif current_store.active == false && current_store.approved?
        redirect_to root_path,
                  alert: "#{current_store.name} is currently down for maintenance."
        return
      elsif current_store.approved?
        @products = current_store.products
        @categories = current_store.categories
      else
        # 404
        redirect_to root_path,
                        alert: "The store you are looking for does not exist."
        return
      end
    else
      # 404
      redirect_to root_path,
                        alert: "The store you are looking for does not exist."
      return
    end
  end

  def show
    session[:return_to] = request.fullpath
    @product = Product.find(params[:id])
    if current_store && current_store.id == @product.store_id
      render :show
    else
      redirect_to root_path, alert: "The product you are looking for does not exist."
    end
  end
end
