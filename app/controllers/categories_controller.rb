class CategoriesController < ApplicationController
  def index
    @categories = current_store.categories
  end
end