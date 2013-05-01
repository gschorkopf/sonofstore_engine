require 'spec_helper'

describe StoresController do
  before (:each) do
    ApplicationController.stub!(:require_admin).and_return(true)
  end

  def valid_attributes
    { name: "MyString", path: 'my-string', description: 'stringy for sure' }
  end

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
        customer = create(:customer)
        user = create(:user, customer_id: customer.id)
        controller.stub(:current_user).and_return(user)
        expect {
          post :create, {:store => valid_attributes}
        }.to change(Store, :count).by(1)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved store as @store" do
        Store.any_instance.stub(:save).and_return(false)
        post :create, {:store => { "name" => "invalid value" }}, valid_session
        assigns(:store).should be_a_new(Store)
      end

      it "re-renders the 'new' template" do
        Store.any_instance.stub(:save).and_return(false)
        post :create, {:store => { "name" => "invalid value" }}, valid_session
        response.should render_template("new")
      end
    end
  end
end
