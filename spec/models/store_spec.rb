require 'spec_helper'

describe Store do
  it 'has a valid factory' do
    expect(FactoryGirl.build(:store)).to be_valid
  end

  it 'is not valid without a name' do
    store = FactoryGirl.build(:store, name: '')
    expect(store.valid?).to be_false
  end

  it 'is not valid without a path' do
    store = FactoryGirl.build(:store, path: '')
    expect(store.valid?).to be_false
  end

  it 'is not valid without a description' do
    store = FactoryGirl.build(:store, description: '')
    expect(store.valid?).to be_false
  end

  context 'given a previous store with same info was declined' do
    it 'can be valid' do
    declined_store = FactoryGirl.create(:store, approval_status: 'declined')
    expect(FactoryGirl.build(:store).valid?).to be_true
    end
  end

  describe '#filter_products_by_category' do
    context 'a category exists' do
      it "should return an array of products that have that category" do
      store = FactoryGirl.build(:store, name:"store", path:"storepath")
      category1 = store.categories.build(title: "category 1")
      category2 = store.categories.build(title: "category 2")
      store.save!

      product1 = FactoryGirl.create(:product, title: "p1", store_id: store.id)
      product1.categories << category1

      product2 = FactoryGirl.create(:product, title: "p2", store_id: store.id)
      product2.categories << category1
      product2.categories << category2

      categories = store.filter_products_by_category(category2.id)
      expect(categories).to eq [product2]
      end
    end

  end

  describe "#top_products" do

    it "sorts the top rated products based on average rating for a given store" do
      store = create(:store)

      product1 = create(:product, store: store)
      product2 = create(:product, store: store)
      product3 = create(:product, store: store)
      product4 = create(:product, store: store)
      product5 = create(:product, store: store)

      prod_review1 = create(:product_review, product_id: product1.id)
      prod_review2 = create(:product_review, product_id: product2.id)
      prod_review3 = create(:product_review, product_id: product3.id)
      prod_review4 = create(:product_review, product_id: product4.id)
      prod_review5 = create(:product_review, product_id: product5.id)

      rating1 = create(:rating, product_review: prod_review1, rating: 5)
      rating2 = create(:rating, product_review: prod_review2, rating: 4)
      rating3 = create(:rating, product_review: prod_review3, rating: 3)
      rating4 = create(:rating, product_review: prod_review4, rating: 2)
      rating5 = create(:rating, product_review: prod_review5, rating: 1)

      expect(store.top_products).to eq [product1, product2, product3, product4]
    end
  end

  describe "search" do

    context "a sorted_by value exists" do
      it "returns the products sorted by the average rating from highest to lowest" do
        p1 = FactoryGirl.create(:search_product)
        p2 = FactoryGirl.create(:search_product, store: p1.store)
        p3 = FactoryGirl.create(:search_product, store: p1.store)

        products = p1.store.search(sorted_by: "average_rating")
        expect(products).to eq [p1, p2, p3].sort_by { |p| -p.average_rating }
      end

      it "returns the products sorted by the rating of a question from highest to lowest" do
        product1 = FactoryGirl.create(:search_product)
        product1_rating = product1.ratings.first
        product1_rating.rating = 5
        product1_rating.save!

        question = Question.first

        product2 = FactoryGirl.create(:search_product, store: product1.store)
        product2_rating = product2.ratings.first
        product2_rating.question = question
        product2_rating.rating = 1
        product2_rating.save!

        product3 = FactoryGirl.create(:search_product)
        product3_rating = product2.ratings.first
        product3_rating.question = question
        product3_rating.rating = 1
        product3_rating.save!

        products = product1.store.search(sorted_by: question.id)
        expect(products).to eq [product1, product2]
      end

      it "returns filtered products sorted by the rating of a question from highest to lowest" do

        store = FactoryGirl.create(:store)

        category = FactoryGirl.create(:category, store: store)

        product1 = FactoryGirl.create(:search_product, store: store)
        product1.categories << category
        product1.save!
        product1_rating = product1.ratings.first
        product1_rating.rating = 5
        product1_rating.save!

        question = Question.first

        product2 = FactoryGirl.create(:search_product, store: store)
        product2.categories << category
        product2.save!
        product2_rating = product2.ratings.first
        product2_rating.question = question
        product2_rating.rating = 1
        product2_rating.save!

        product3 = FactoryGirl.create(:search_product, store: store)
        product3_rating = product1.ratings.first
        product3_rating.question = question
        product3_rating.rating = 3
        product3_rating.save!

        products = store.search(category_id: category.id, sorted_by: question.id)
        expect(products).to eq [product1, product2]
      end
    end
  end

end
