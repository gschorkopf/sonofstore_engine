require 'spec_helper'

describe OrdersController do
  describe 'create' do
    pending
  end

  describe 'index' do
    context 'when the user is logged in' do

      context 'when the user has orders in their history' do
        before(:each) do
          @customer = FactoryGirl.create(:customer)
        end

        it 'renders the index view' do
          user = FactoryGirl.create(:user, customer_id: @customer.id)
          login_user user
          expect(response).to be_success
        end

        it 'assigns the user variable' do
          user = FactoryGirl.create(:user, customer_id: @customer.id)
          login_user user
          get :index
          assigns(user).should eq @user
        end

      context 'when the user does not have orders in their history' do
        before(:each) do 
          @customer = FactoryGirl.create(:customer)
        end

          it 'renders the index view with no orders' do
            user = FactoryGirl.create(:user, customer_id: @customer.id)
            login_user user
            get :index
            assigns(:orders).should be_empty
          end
        end
      end
    end
  end

  describe 'show' do
    context 'when the user is logged in' do

      context 'when the order belongs to the user' do
        it 'assigns the order variable' do
          customer = FactoryGirl.create(:customer)
          user = FactoryGirl.create(:user, customer_id: customer.id)
          order = FactoryGirl.create(:order, customer: customer)
          login_user user
          get :show, params = {id: order.id}
          assigns(order).should eq @order
        end
      end

      context 'when the order does NOT belong to the user' do
        it 'redirects to the order history' do
          customer1 = FactoryGirl.create(:customer)
          customer2 = FactoryGirl.create(:customer, email: 'what@where.com')
          user = FactoryGirl.create(:user, customer_id: customer1.id)
          user2 = FactoryGirl.create(:user,customer_id: customer2.id)
          order = FactoryGirl.create(:order, customer: customer1)
          login_user user2

          get :show, params = {customer_id: customer1.id, id: order.id}
          expect(response).to redirect_to customer_orders_path(customer2)
        end
      end
    end
  end
end
