require 'spec_helper'

describe Admin::OrdersController do
  it "index action should render index template" do
    # pending "this test requires current_store... how do we stub?"
    controller.stub(:require_admin => true)
    store = FactoryGirl.create(:store)
    controller.stub(:current_store).and_return(store)

    get :index
    response.should render_template(:index)
  end

  it "index action should return a collection of orders" do
    pending
    # controller.stub(:require_admin => true)
    # customer = FactoryGirl.create(:customer)
    # user = FactoryGirl.create(:user, customer_id: customer.id)
    # orders = [FactoryGirl.create(:order, customer: customer)]
    # store = FactoryGirl.create(:store)

    # get :index , stub(current_store.id).and_return(store.id)
    # expect(assigns(:orders)).to match_array orders
  end

  it "show action should return an individual order" do
    controller.stub(:require_admin => true)
    customer = FactoryGirl.create(:customer)
    user = FactoryGirl.create(:user, customer_id: customer.id)
    order = FactoryGirl.create(:order, customer: customer)

    get :show, id: order.id
    expect(assigns(:order)).to eq order
  end

  describe 'update' do
    it 'works correctly' do
      controller.stub(:require_admin => true)
      customer = FactoryGirl.create(:customer)
      user = FactoryGirl.create(:user, customer_id: customer.id)
      order = FactoryGirl.create(:order, customer: customer)

      request.env["HTTP_REFERER"] = '/'
      post :update, id: order.id, update_status: 'pending'
      expect(order.status).to eq 'pending'
    end
  end
end
