class ProductsController < ApplicationController

  before_filter :store_does_not_exist

  def index
    if current_store.inactive?
      redirect_to root_path,
              alert: "#{current_store.name} is currently down for maintenance."
    else
      begin
        @products = paginate(current_store.search(category_id: params[:category_id],
                                         sorted_by: params[:sorted_by]))
      rescue ::ActiveRecord::RecordNotFound

        flash.alert = "The category doesn't exist"
        @products = paginate(current_store.search(sorted_by: params[:sorted_by]))
      end

    end
  end

  def show

    @product ||= current_store.products.find_by_id(params[:id])

    if @product
      render :show
    else
      redirect_to store_home_path(current_store),
        alert: "The product you are looking for does not exist."
    end
  end

  private

  def store_does_not_exist
    if !current_store || current_store.pending?
      redirect_to root_path, status: 404,
        alert: "The store you are looking for does not exist."

    end
  end

  def paginate records
    records.page(params[:page]).per(40)
  end

end
