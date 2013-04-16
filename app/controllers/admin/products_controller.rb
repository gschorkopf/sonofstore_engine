class Admin::ProductsController < ApplicationController
  before_filter :require_admin

  def index
    @store = current_store
    @products = @store.products.order('title ASC').all
  end

  def new
    @store = current_store
    @product = Product.new
  end

  def create
    @store = current_store
    @product = Product.new(params[:product], store_id: @store.id)
    if @product.save
      redirect_to store_admin_products_path,
        :notice => "Successfully created product."
    else
      render :action => 'new', :notice  => "Product creation failed."
    end
  end

  def edit
    @store = current_store
    @product = Product.find(params[:id])
  end

  def update
    @store = current_store
    @product = Product.find(params[:id])
    if @product.update_attributes(params[:product])
      redirect_to store_admin_products_path,
        :notice  => "Successfully updated product."
    else
      render :action => 'edit', :notice  => "Update failed."
    end
  end

  def destroy
    @store = current_store
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to store_admin_products_path,
      :notice => "Successfully destroyed product."
  end

  def toggle_status
    @store = current_store
    @product = Product.find(params[:id])
    if @product.toggle_status
      redirect_to store_admin_products_path,
        :notice  => "Product status successfully set to '#{@product.status}'."
    else
      head 400
    end
  end
end
