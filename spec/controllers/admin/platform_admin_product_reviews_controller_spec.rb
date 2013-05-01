require 'spec_helper'

describe Admin::PlatformAdminProductReviewsController do
  before(:each) do
    controller.stub(:require_platform_admin).and_return(true)
  end

  describe 'GET #index' do
    it 'assigns the flagged product reviews' do
      @product_reviews = [create(:product_review, status: 'flagged')]
      get :index
      assigns(:product_reviews).should eq @product_reviews
    end

    it 'renders the index template' do
      get :index
      response.should render_template(:index)
    end
  end

  describe 'POST #update' do
    before(:each) do
      @pr = create(:product_review, status: 'flagged')
    end

    context 'when setting the pr to active' do
      it 'changes the status of the product review to active' do
        ProductReview.any_instance.should_receive(:update_attributes).with({status: 'active'})
        post :update, {id: @pr.id, status: 'active'}
      end

      it 'redirects to the reviews index page' do
         post :update, {id: @pr.id, status: 'active'}
         response.should redirect_to admin_product_reviews_path
      end
    end

    context 'when setting the pr to inactive' do
      it 'changes the status of the pr to inactive' do
        ProductReview.any_instance.should_receive(:update_attributes).with({status: 'inactive'})
        post :update, {id: @pr.id, status: 'inactive'}
      end

      it 'redirects to the reviews index page' do
        post :update, {id: @pr.id, status: 'inactive'}
        response.should redirect_to admin_product_reviews_path
      end
    end
  end
end
