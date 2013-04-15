require File.dirname(__FILE__) + '/../spec_helper'

describe ProductsController do
  describe 'GET #index' do
    context 'given a store that is active' do
      it "index action should render index template" do
        pending 'need to figure out how to create a current_store'
        get :index
        response.should render_template(:index)
      end
    end

    context 'given a store that is pending' do
      it 'index action should provide a 401 error' do
        pending 'need to figure out how to create a current_store'
        get :index
        expect(response.status).to eq '404'
      end
    end
  end
end
