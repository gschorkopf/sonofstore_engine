require 'spec_helper'

describe ProductReviewsController do
  before do
    Product.stub(:find).and_return(Product.new)
    #controller.stub(:require_login).and_return(true)
    user = FactoryGirl.create(:user)
    login_user(user)
  end
  describe 'GET #new' do

    it 'assigns a new product review' do
      #product_review = ProductReview.new
      get :new
      expect(assigns(:product_review)).to be_a_new(ProductReview)
    end

    # it 'assigns new product_ratings' do

    # end

    it 'renders the new template' do
      get :new
      response.should render_template(:new)
    end
  end

  describe "GET #edit" do
    before(:each) do
      @product_review = ProductReview.create(product_id: 1 , customer_id: 1 , comment: 'this is so fun')
      get :edit , :id => @product_review.id
    end

    it 'assigns the specific product review' do
      expect(assigns(:product_review)).to eq @product_review
    end

    it 'renders the edit template' do
      response.should render_template(:edit)
    end
  end

  describe "POST #create" do
    before(:each) do
      @current_store = Store.create(name: 'HoneyBooBoo', path: 'honey-boo-boo', description: "some store")
      @current_store.approval_status = 'accepted'
      @current_store.active = true
      @current_store.save

      @product = FactoryGirl.create(:product, store: @current_store)
      @question = create(:question)
    end
    context 'when the product review is good' do
      before do
        Rating.should_receive(:make_new_ratings).and_return(true)
      end
      it 'creates a new product review' do


        expect{ post :create, store_path: @current_store.path,
          product_review: {product_id: @product.id,
            customer_id: 1 ,
            comment: 'this is so fun'},
            ratings: [{rating: 1, question_id: @question.id}]
        }.to change(ProductReview, :count).by(1)
      end

      it 'redirects to the product show page' do
        post :create, store_path: @current_store.path,
          product_review: {product_id: @product.id,
            customer_id: 1 ,
            comment: 'this is so fun'},
            ratings: [{rating: 1, question_id: @question.id}]
        expect(response).to redirect_to(store_product_path(store_path: @current_store.path, id: @product.id))
      end
    end

    context 'when there is something wrong with the product review' do
      it 'redirects to the new page' do
        Rating.should_receive(:make_new_ratings).and_return(false)
        post :create, store_path: @current_store.path, product_review: {product_id: @product.id, customer_id: '' , comment: 'this is so fun'}
        response.should render_template(:new)
      end
    end
  end

  describe "POST #update" do
    context 'when the update is valid' do
      it 'successfully changes the review' do
        pending 'next iteration'
      end
    end

    context 'when the update is not valid' do
      it 'doesnt go through ' do
        pending 'next iteration!'
      end
    end
  end
end
