class Admin::PlatformAdminProductReviewsController < ApplicationController
  before_filter :require_platform_admin

  def index
    @product_reviews ||= ProductReview.where(status: 'flagged').includes(:customer, :product)
  end

  def update
    product_review = ProductReview.find(params[:id])
    if product_review.update_attributes(status: params[:status])
      redirect_to admin_product_reviews_path, notice: 'Successfully updated'
    else
      redirect_to admin_product_reviews_path,
      notice: 'The site gremlins have ATTACKED!'
    end
  end
end
