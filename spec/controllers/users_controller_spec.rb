require 'spec_helper'

describe UsersController do
  describe "new" do
    it 'returns the new page' do
      get :new
      response.should be_success
    end
  end

  describe "create" do
    it 'saves a new user with valid params' do
      pending
      post :create
    end

    it 'rejects a new user with invalid params' do
      pending
    end
  end

  describe 'update' do
    it 'updates a users params if theyre valid' do
      pending
    end

    it 'rejects invalid user update params' do
      pending
    end
  end

  describe "GET#show" do
    context 'when a user is logged in' do

      before(:each) do
        customer = FactoryGirl.create(:customer)
        @user = FactoryGirl.create(:user, customer_id: customer.id)
        login_user @user
      end

      it 'assigns the correct user' do
        get :show
        assigns(:user).should eq @user
      end

       it 'returns a page with users account details' do
        get :show
        response.should render_template(:show)
      end
    end

    context 'when a user is NOT logged in' do
      render_views
      it 'redirects them to the home page' do
        get :show
        response.should redirect_to(login_path)
      end
    end
  end
end
