class CategoriesController < ApplicationController
  def index
    @store ||= current_store
    @categories = current_store.categories.page(params[:page]).per(40)
  end

  def show
    @store = current_store
    @category = Category.find(params[:id])
  end
end
