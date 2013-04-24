require 'spec_helper'

describe ProductReviewsController do
  describe 'GET #new' do
    it 'assigns a new product review' do
      product_review = ProductReview.new
      get :new
      expect(assigns(:product_review)).to be_a_new(ProductReview)
    end

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
      end
    context 'when the product review is good' do
      it 'creates a new product review' do
        expect{ post :create, store_path: @current_store.path, product_review: {product_id: @product.id, customer_id: 1 , comment: 'this is so fun'}
        }.to change(ProductReview, :count).by(1)
      end

      it 'redirects to the product show page' do
        post :create, store_path: @current_store.path, product_review: {product_id: @product.id, customer_id: 1 , comment: 'this is so fun'}
        expect(response).to redirect_to(store_product_path(store_path: @current_store.path, id: @product.id))
      end
    end

    context 'when there is something wrong with the product review' do
      it 'redirects to the new page' do
        post :create, store_path: @current_store.path, product_review: {product_id: @product.id, customer_id: '' , comment: 'this is so fun'}
        response.should render_template(:new)
      end
    end
  end

  describe "POST #update" do
  end
end
