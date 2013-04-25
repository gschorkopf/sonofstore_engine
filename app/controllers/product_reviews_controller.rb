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
    #params look like:
      #product_review { product_id: x , customer_id: x, comment: x }
      #ratings: multiple times of.. { product_review_id: x, question: x, rating: x }
     @product_review = ProductReview.new(params[:product_review])
     @product_review.customer = current_user.customer
     @product_review.product_id = params[:product_id]
     # need to check to see if the ratings are valid before saving review
    if @product_review.save
      @product_ratings = Rating.make_new_ratings( params[:ratings].values,
                                                @product_review.id)
      if @product_ratings
        redirect_to store_product_path( store_path: current_store.path,
                                        id: @product_review.product_id
                                      ),
        notice: 'Successfully created new product review!'
      else
        render :new, notice: 'Something went wrong.'
      end

    else
      @product = Product.find(params[:product_id])

      render :new, notice: 'Something went wrong.'
    end
    # @product_review = ProductReview.new(params[:product_review])
    # if @product_review.save
    #   redirect_to store_product_path( store_path: current_store.path,
    #                                   id: @product_review.product_id
    #                                 ),
    #   notice: 'Successfully created new product review!'
    # else
    #   render :new, notice: 'Something went wrong.'
    # end
  end

  def update
  end

  def edit
    @product_review = ProductReview.find(params[:id])
  end
end
