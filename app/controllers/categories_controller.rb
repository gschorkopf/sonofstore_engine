class CategoriesController < ApplicationController
  def index
    @store = current_store
    @categories = Category.find_all_by_store_id(@store.id)
  end

  def show
    @store = current_store
    @category = Category.find(params[:id])
  end
end