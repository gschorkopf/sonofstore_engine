require File.dirname(__FILE__) + '/../spec_helper'

describe Product do
  before(:each) do
    @store = FactoryGirl.create(:store)
    @product = FactoryGirl.create(:product, store_id: @store.id)
  end

  it 'has a valid factory' do
    expect(@product).to be_valid
  end

  it 'is invalid without a title' do
    @product.title = ''
    expect(@product).to_not be_valid
  end

  it 'is invalid without a description' do
    @product.description = ''
    expect(@product).to_not be_valid
  end

  it 'is invalid without a store id' do
    #this is failing because it cannot do a custom validation without a store id
    @product.store_id = ''
    expect(@product.valid?).to be_false
  end

  it 'is invalid if title already exists in the same store' do
    product2 = FactoryGirl.create(:product, store_id: @store.id, title: @product.title)
    expect(product2.valid?).to be_false
  end

  it 'is invalid if title already exists (case insensitive) in the same store' do
    product2 = FactoryGirl.create(:product, title: 'ITCHY Sweater',
                                  store_id: @store.id,
                                  title:@product.title.upcase)
    expect(product2.valid?).to be_false
  end

  it 'is valid if the title already exists in a different store' do
    @product.save
    store2 = FactoryGirl.create(:store, name: 'KimChi Caravan', path: 'kimchi-caravan')
    product2 = FactoryGirl.create(:product, title: 'Itchy Sweater', store_id: store2.id)
    expect(product2).to be_valid
  end

  it 'is invalid without a price' do
    @product.price = nil
    expect(@product).to_not be_valid
  end

  it 'is invalid without a price greater than 0' do
    @product.price = 0
    expect(@product).to_not be_valid
  end

  it 'is only valid with two or less decimal points' do
    expect(FactoryGirl.build(:product, store_id: @store.id, price: 0.123)).to_not be_valid
    expect(FactoryGirl.build(:product, store_id: @store.id, price: 0.10)).to be_valid
    expect(FactoryGirl.build(:product, store_id: @store.id, price: 0.1)).to be_valid
    expect(FactoryGirl.build(:product, store_id: @store.id, price: 2)).to be_valid
  end

  it 'is invalid without a status' do
    @product.status = nil
    expect(@product).to_not be_valid
  end

  it 'is invalid with a status other than active or retired' do
    expect(FactoryGirl.build(:product, store_id: @store.id, status: 'active')).to be_valid
    expect(FactoryGirl.build(:product, store_id: @store.id, status: 'retired')).to be_valid
    expect(FactoryGirl.build(:product, store_id: @store.id, status: 'something')).to_not be_valid
  end

  it 'has the ability to be assigned to multiple categories' do
    nicknacks = FactoryGirl.create(:category, title: 'nicknacks', store_id: @store.id)
    superheroes = FactoryGirl.create(:category, title: 'superheroes', store_id: @store.id)
    product = FactoryGirl.create(:product, store_id: @store.id, categories: [nicknacks, superheroes])
    expect(product.categories.count).to eq 2
  end

  describe '.toggle_status' do
    context 'on an active product' do
      it 'sets the status from active to retired' do
        product = FactoryGirl.create(:product, store_id: @store.id, status: 'active')
        product.toggle_status
        expect(product.status).to eq 'retired'
      end
    end

    context 'on a retired product' do
      it 'sets the status to active' do
        product = FactoryGirl.create(:product, store_id: @store.id, status: 'retired')
        product.toggle_status
        expect(product.status).to eq 'active'
      end
    end
  end

  describe "most recent reviews" do
    let!(:product) { create(:product, store_id: @store.id, status: 'retired') }

    context "when there are product reviews" do
      it "sorts the reviews by the updated at time" do
        product_review1 = build(:product_review, product_id: product.id,
                                updated_at: 1.years.ago)
        product_review2 = build(:product_review, product_id: product.id,
                                updated_at: 3.years.ago)
        product_review3 = build(:product_review, product_id: product.id,
                                updated_at: 5.years.ago)

        [product_review1, product_review2, product_review3].tap do |reviews|
          product.product_reviews << reviews
          expect(product.most_recent_reviews).to eq reviews
        end
      end
    end

    context "when there are no product reviews" do
      it "returns an empty array" do
        expect(product.most_recent_reviews).to eq []
      end
    end
  end

  describe "average ratings" do

    it "returns a hash of questions and average ratings" do
      q1 = Question.new(question: "question 1")
      q2 = Question.new(question: "question 2")

      rating1 = Rating.new
      rating1.question = q1
      rating1.rating = 2

      rating2 = Rating.new
      rating2.question = q2
      rating2.rating = 3

      pr1 = ProductReview.new
      pr1.should_receive(:ratings).and_return([rating1, rating2])

      rating1 = Rating.new
      rating1.question = q1
      rating1.rating = 4

      rating2 = Rating.new
      rating2.question = q2
      rating2.rating = 3

      pr2 = ProductReview.new
      pr2.should_receive(:ratings).and_return([rating1, rating2])
      product_reviews = [pr1, pr2]
      product = Product.new

      product.should_receive(:product_reviews).at_least(:once).and_return(product_reviews)

      average_ratings = {"question 1" => 3, "question 2" => 3}
      expect(product.average_ratings).to eq average_ratings
    end
  end

  describe "reviewers" do
    it "returns a collection of customers who have reviewed the product" do
      c1 = Customer.create!(email:"a@a.a", full_name:"a")
      c2 = Customer.create!(email:"b@b.b", full_name:"b")

      product = FactoryGirl.create(:product)

      pr = ProductReview.new
      pr.customer = c1
      pr.product = product
      pr.save!

      expect(product.reviewers).to eq [c1]
    end
  end

  describe "reviewed_by?" do
    let(:c1) {Customer.create!(email:"a@a.a", full_name:"a")}
    let(:c2) {Customer.create!(email:"b@b.b", full_name:"b")}
    let(:product) {FactoryGirl.create(:product)}

    before do
      pr = ProductReview.new
      pr.customer = c1
      pr.product = product
      pr.save!

    end

    it "returns true if a customer reviewed the product" do
      expect(product).to be_reviewed_by(c1)
    end

    it "returns false if a customer didn't review the product" do
      expect(product).to_not be_reviewed_by(c2)
    end
  end

  describe "featured_comments" do
    it "returns an array of product reviews that are featured" do
      c1 = Customer.create!(email:"a@a.a", full_name:"a")
      c2 = Customer.create!(email:"b@b.b", full_name:"a")
      product = FactoryGirl.create(:product)

      pr1 = ProductReview.new
      pr1.customer = c1
      pr1.product = product
      pr1.featured = true
      pr1.save!

      pr2 = ProductReview.new
      pr2.customer = c2
      pr2.product = product
      pr1.featured = false
      pr2.save!

      expect(product.featured_comments).to eq [pr1]
    end
  end

  describe "featured_comment" do
    context "a featured comment exists" do
      it "returns a featured comment" do
        c1 = Customer.create!(email:"a@a.a", full_name:"a")
        c2 = Customer.create!(email:"b@b.b", full_name:"a")
        product = FactoryGirl.create(:product)

        pr1 = ProductReview.new
        pr1.customer = c1
        pr1.product = product
        pr1.comment = "a comment"
        pr1.featured = true
        pr1.save!

        pr2 = ProductReview.new
        pr2.customer = c2
        pr2.product = product
        pr2.comment = "blahblahblah"
        pr1.featured = false
        pr2.save!

        expect(product.featured_comment).to eq "a comment"
      end
    end
    context "a featured comment does not exist" do
      it "returns a featured comment" do
        c1 = Customer.create!(email:"a@a.a", full_name:"a")
        c2 = Customer.create!(email:"b@b.b", full_name:"a")
        product = FactoryGirl.create(:product)

        pr1 = ProductReview.new
        pr1.customer = c1
        pr1.product = product
        pr1.comment = "a comment"
        pr1.featured = false
        pr1.save!

        pr2 = ProductReview.new
        pr2.customer = c2
        pr2.product = product
        pr2.comment = "blahblahblah"
        pr1.featured = false
        pr2.save!

        expect(product.featured_comment).to eq nil
      end
    end
  end
end
