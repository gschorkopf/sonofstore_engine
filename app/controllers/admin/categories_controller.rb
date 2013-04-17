class Admin::CategoriesController < ApplicationController
  before_filter :require_admin

  def index
    @store = current_store
    @categories = Category.find_all_by_store_id(@store.id)
  end

  def show
    @store = current_store
    @category = Category.find(params[:id])
  end

  def new
    @store = current_store
    @category = Category.new
  end

  def create
    @category = Category.new(params[:category])
    @store = @category.store
    if @category.save
      expire_fragment("categories_index_#{@store.path}")

      redirect_to store_admin_categories_path(@store),
      :notice => "Successfully created category."
    else
      render :action => 'new'
    end
  end

  def edit
    @user = current_user
    @store = current_store
    @category = Category.find(params[:id])

    expire_fragment("categories_index_#{@store.path}")
  end

  def update
    @category = Category.find(params[:id])
    @store = @category.store
    if @category.update_attributes(params[:category])
      expire_fragment("categories_index_#{@store.path}")

      redirect_to store_admin_categories_path(@store),
      :notice  => "Successfully updated category."
    else
      render :action => 'edit'
    end
  end
end
