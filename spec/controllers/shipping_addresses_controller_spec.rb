require 'spec_helper'

describe ShippingAddressesController do
  before(:each) do
    @customer = create(:customer)
    user = create(:user, customer: @customer)
    @shipping_address = create(:shipping_address, customer_id: @customer.id)
    controller.stub(:current_user).and_return(user)
  end

  describe 'GET #new' do
    it 'renders the new template' do
      get :new
      response.should render_template('new')
    end
  end

  describe 'GET #edit' do
    it 'assigns the customer' do
      get :edit
      assigns(:customer).should eq @customer
    end

    it 'assigns the associated shipping address' do
      get :edit
      assigns(:shipping_address).should eq @shipping_address
    end
  end

  describe 'POST #update' do
    it 'assigns the customer' do
      post :update
      assigns(:customer).should eq @customer
    end
  end
end
