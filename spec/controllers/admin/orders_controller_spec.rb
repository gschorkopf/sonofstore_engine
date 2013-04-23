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
    store = FactoryGirl.create(:store)
    controller.stub(:require_admin => true)
    controller.stub(:current_store => store)
    customer = FactoryGirl.create(:customer)
    orders = [FactoryGirl.create(:order, store_id: store.id, customer_id: customer.id)]

    get :index
    expect(assigns(:orders)).to match_array orders
  end

  it "show action should return an individual order" do
    controller.stub(:require_admin => true)
    customer = FactoryGirl.create(:customer)
    order = FactoryGirl.create(:order, customer_id: customer.id)
    get :show, id: order.id
    expect(assigns(:order)).to eq order
  end

  describe 'update' do
    it 'works correctly' do
      controller.stub(:require_admin => true)
      customer = FactoryGirl.create(:customer)
      order = FactoryGirl.create(:order, customer_id: customer.id)
      request.env["HTTP_REFERER"] = '/'
      post :update, id: order.id, update_status: 'pending'
      expect(order.status).to eq 'pending'
    end
  end
end
