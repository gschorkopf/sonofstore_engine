require 'spec_helper'

describe Admin::ProductsController do
  fixtures :all
  render_views
  before(:each) do
    @store = FactoryGirl.create(:store)
  end

  it "index action should render index template" do
    controller.stub(:require_admin => true)
    controller.stub(:current_store).and_return(@store)

    get :index, store_path: @store

    response.should render_template(:index)
  end

  it "new action should render new template" do
    controller.stub(:require_admin => true)
    controller.stub(:current_store).and_return(@store)

    get :new, store_path: @store
    response.should render_template(:new)
  end
end
