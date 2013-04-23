require 'spec_helper'

describe Rating do
  before(:each) do
    @question = Question.create(question: "Do you like this product?")
    @customer = Customer.create(email: "thisisfake@gmail.com", full_name: "John Smith")
    @product_review = ProductReview.create(product_id: 1, customer_id: @customer.id, comment: "hi")
  end

  it 'can create a new rating' do
    rating = Rating.new(question_id: @question.id, rating: 2, product_review_id: @product_review.id)
    expect(rating).to be_valid
  end

  it 'has a valid factory'do
    expect(FactoryGirl.build(:rating)).to be_valid
  end

  it 'is not valid without all attributes' do
    pending
  end
end
