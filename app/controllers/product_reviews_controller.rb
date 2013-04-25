class ProductReviewsController < ApplicationController

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
    #params look like:
      #product_review { product_id: x , customer_id: x, comment: x }
      #ratings: multiple times of.. { product_review_id: x, question: x, rating: x }
     @product_review = ProductReview.new(params[:product_review])

     # need to check to see if the ratings are valid before saving review
    if @product_review.save
      @product_ratings = Rating.make_new_ratings( params[:ratings],
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
