require 'spec_helper'

describe CreditCardsController do
  before(:each) do
    @customer = create(:customer)
    user = create(:user, customer: @customer)
    @credit_card = create(:credit_card, customer_id: @customer.id)
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

    it 'assigns the associated billing address' do
      get :edit
      assigns(:credit_card).should eq @credit_card
    end
  end

  describe 'POST #update' do
    it 'assigns the customer' do
      post :update
      assigns(:customer).should eq @customer
    end
  end
end
