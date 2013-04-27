class Admin::ProductReviewsController < ApplicationController
  before_filter :require_admin

  def update
    @product_review = ProductReview.find(params[:id])

    if @product_review.update_attributes(featured: params[:featured])
      redirect_to store_admin_products_path(current_store),
      notice: 'Successfully Updated Product Review Featured Status'
    else
      render :index,
      notice: 'Failed to update Product Review Featured Status'
    end
  end

end
