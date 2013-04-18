require 'spec_helper'

def valid_params
 {street: '123 Main St', city: 'Des Moines', state: 'Iowa', zip: '29505'}
end

describe OrdersController do
 describe 'new' do
  it 'returns the new page' do
    get :new
    response.should be_success
  end
 end

 describe 'POST#create' do
    it 'makes a new billing address with valid params' do
      @customer = FactoryGirl.create(:customer)

        post :create, params = {customer_id: @customer.id, :billing_address => valid_params}
        expect(response).to be_success
    end
  end





 describe 'edit' do
 end

 describe 'update' do
 end
end
