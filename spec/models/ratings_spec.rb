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

  describe 'making new ratings' do
    it 'creates multiple new ratings at a time' do
     question1 =  create(:question)
      question2 = create(:durability_question)
      question3 = create(:packaging_question)
      question4 = create(:description_accuracy_question)

      product = create(:product)
      product_review = create(:product_review, product: product)

      #create the ratings
      ratings = [
        {question_id: question1.id, rating: 5 },
        {question_id: question2.id, rating: 3 },
        {question_id: question3.id, rating: 2 },
        {question_id: question4.id, rating: 1 }
      ]
      
      expect{  Rating.make_new_ratings(ratings, product_review.id) }.to change(Rating, :count).by(4)
    end
  end
end
