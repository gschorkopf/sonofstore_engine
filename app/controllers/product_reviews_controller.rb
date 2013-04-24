class ProductReviewsController < ApplicationController

  def new
    @product_review = ProductReview.new
  end

  def create
    #if successful redirect to product's show page
    @product_review = ProductReview.new(params[:product_review])
    if @product_review.save
      redirect_to store_product_path(store_path: current_store.path, id: @product_review.product_id),
      notice: 'Successfully created new product review!'
    else
      render :new, notice: 'Something went wrong.'
    end
  end

  def update
  end

  def edit
    @product_review = ProductReview.find(params[:id])
  end
end
