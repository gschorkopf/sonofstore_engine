class ProductReviewsController < ApplicationController

  before_filter :require_login

  def new
    @product = Product.find(params[:product_id])
    @product_review = ProductReview.new
    questions = Question.all
    questions.each do |q|
      rating = @product_review.ratings.build
      rating.question = q
    end
  end

  def create
    if params[:product_review][:ratings_attributes]
      params[:ratings] = params[:product_review][:ratings_attributes]
      params[:product_review].delete(:ratings_attributes)
    end
     @product_review = ProductReview.make_new_product_review(
                                                      params[:product_review],
                                                      params[:product_id],
                                                      current_user.customer.id
                                                      )
    if @product_review.save && !(params[:ratings].nil? || params[:ratings].empty?)
      @product_ratings = Rating.make_new_ratings( params[:ratings].values,
                                                @product_review.id)
      if @product_ratings
        redirect_to store_product_path( store_path: current_store.path,
                                        id: @product_review.product_id
                                      ),
        notice: 'Successfully created new product review!'
      else
        redirect_to new_store_product_review_path(
                                      store_path: current_store.path,
                                      id: @product_review.product_id
                                      ),
        notice: 'Something went wrong.'
      end

    else
      @product = Product.find(params[:product_id])
      render :new, notice: 'Something went wrong.'
    end
  end

  def flag
    #params look like { product_id: x, product_review_id: x, status: 'flagged'}
    if params[:status] == 'flagged'
      product_review = ProductReview.find(params[:review_id])
      product_review.update_attribute(:status, 'flagged')
      redirect_to store_product_path( store_path: current_store.path,
                                      id: params[:product_id]
                                    ),
      notice: 'Thank you for reporting this inappropriate review.'
    else
      redirect_to store_product_path( store_path: current_store.path,
                                      id: params[:product_id]
                                    ),
      notice: 'Failed to flag this review.'
    end
  end
end
