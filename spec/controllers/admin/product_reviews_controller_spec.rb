require 'spec_helper'

describe Admin::ProductReviewsController do

  # describe "GET index" do
  #   before(:each) do
  #     @store = FactoryGirl.create(:store)
  #     controller.stub(:require_admin => true)
  #     controller.stub(:current_store).and_return(@store)
  #     @product = create(:product, store: @store)
  #     @featured_comment = create(:featured_product_review, product: @product)
  #     @nonfeatured_comment = create(:product_review, product: @product)
  #   end

  #   it "assigns featured product comments" do
  #     get 'index'
  #     expect(assigns(:featured_comments)).to eq [@featured_comment]
  #   end

  #   it "assigns nonfeatured product comments" do
  #     get 'index'
  #     expect(assigns(:nonfeatured_comments)).to eq [@nonfeatured_comment]
  #   end

  #   it 'renders the index template' do
  #     get 'index'
  #     response.should render_template(:index)
  #   end
  # end

  describe "POST update" do
    before(:each) do
      @store = FactoryGirl.create(:store)
      controller.stub(:require_admin => true)
      controller.stub(:current_store).and_return(@store)
      @product = create(:product, store: @store)
      @product_review = create(:product_review, product: @product)
    end

    it "assigns the current product review" do
      put :update, {
        :store_path => @store.path,
        :id         => @product_review.id,
        :featured   => true
      }
      expect(assigns(:product_review)).to eq @product_review
    end

    it "changes the featured status of a product review" do
      ProductReview.any_instance.should_receive(:update_attributes).with({
        :featured   => true
      })
      put :update, {
        :store_path => @store.path,
        :id         => @product_review.id,
        :featured   => true
      }
    end

    it "redirects back to the index page after an update" do
      put :update, {
        :store_path => @store.path,
        :id         => @product_review.id,
        :featured   => true
      }
      expect(response).to redirect_to store_admin_product_reviews_path(@store.path)
    end
  end
end
