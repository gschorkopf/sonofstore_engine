require 'spec_helper'

describe BillingAddressesController do
  before (:each) do
    ApplicationController.stub!(:require_login).and_return(true)
  end

  # describe 'GET#new' do
  #   it 'renders the new template' do
  #     get :new
  #     expect(response).to be_success
  #     response.should render_template(:index)
  #   end

  #   it 'creates a new billing address' do
  #   end

  #   context 'when there is a current user' do
  #     it 'assigns the billing address to the customer'
  #   end
  # end

  # describe 'POST#create' do
  # end

  describe 'GET#edit' do
  end

  describe 'PUT#update' do
  end
end
