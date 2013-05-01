require 'spec_helper'

describe Admin::ProductsController do
  fixtures :all
  render_views
  before(:each) do
    @store = create(:store)
    controller.stub(:require_admin => true)
    controller.stub(:current_store).and_return(@store)
    customer = create(:customer)
    current_user = create(:user, customer_id: customer.id)
    controller.stub(:current_user).and_return(current_user)
  end

  describe 'GET index' do
    it "index action should render index template" do
      get :index, store_path: @store
      response.should render_template(:index)
    end

    it "new action should render new template" do
      get :new, store_path: @store
      response.should render_template(:new)
    end
  end
end
