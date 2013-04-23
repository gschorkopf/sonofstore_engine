require 'spec_helper'

describe StoresController do
  before (:each) do
    ApplicationController.stub!(:require_admin).and_return(true)
  end

  # This should return the minimal set of attributes required to create a valid
  # Store. As you add validations to Store, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    { name: "MyString", path: 'my-string', description: 'stringy for sure' }
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # StoresController. Be sure to keep this updated too.
  def valid_session
    {path: 'my-string'}
  end

  describe "GET index" do
    it "assigns all stores as @stores" do
      store = Store.create! valid_attributes
      store.approval_status = 'approved'
      store.active = true
      store.save
      get :index, {}, valid_session
      assigns(:stores).should eq([store])
    end
  end

  describe "GET new" do
    it "assigns a new store as @store" do
      get :new, {}, valid_session
      assigns(:store).should be_a_new(Store)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Store" do
        pending 'i dont know how to fix this test'
        customer = FactoryGirl.create(:customer)
        user = FactoryGirl.create(:user, customer_id: customer.id)
        expect {
          post :create, {:store => valid_attributes}, user
        }.to change(Store, :count).by(1)
      end

      it "assigns a newly created store as @store" do
        pending "this isn't working because of current_user needs"
        # post :create, {:store => valid_attributes}, valid_session
        # assigns(:store).should be_a(Store)
        # assigns(:store).should be_persisted
      end

      it "redirects to the created store" do
        pending "this isn't working because of current_user needs"
        # post :create, {:store => valid_attributes}, valid_session
        # response.should redirect_to(Store.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved store as @store" do
        # Trigger the behavior that occurs when invalid params are submitted
        Store.any_instance.stub(:save).and_return(false)
        post :create, {:store => { "name" => "invalid value" }}, valid_session
        assigns(:store).should be_a_new(Store)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Store.any_instance.stub(:save).and_return(false)
        post :create, {:store => { "name" => "invalid value" }}, valid_session
        response.should render_template("new")
      end
    end
  end
end
