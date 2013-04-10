class CategoriesController < ApplicationController
  def current_store
    @current_store ||= Store.find(params[:store_path])
  end

  def index
    @categories = current_store.categories
  end

end