class Admin::ProductReviewsController < ApplicationController
  before_filter :require_admin

  def index
    @store = current_store
    @product = Product.find(params[:product_id])
    @featured_comments = @product.featured_comments
    @nonfeatured_comments = @product.nonfeatured_comments
  end

  def update
    @product = Product.find(params[:product_id])
    @product_review = ProductReview.find(params[:id])

    if @product_review.update_attributes(featured: params[:featured])
      redirect_to store_admin_product_reviews_path(current_store, @product.id),
      notice: 'Successfully Updated Product Review Featured Status'
    else
      render :index,
      notice: 'Failed to update Product Review Featured Status'
    end
  end

end
