require File.dirname(__FILE__) + '/../spec_helper'

describe ProductsController do
  describe 'GET #index' do
    context 'given a store that is active' do
      it "index action should render index template" do
        pending 'need to figure out how to create a current_store'
        get :index
        response.should render_template(:index)
      end

      context "a category is added as a param" do
        context "the category exists" do
          it "filters products by category" do
            current_store = Store.new
            current_store.active = true
            current_store.stub(:approved?).and_return(true)
            current_store.stub(:pending?).and_return(false)
            products = [Product.new]
            products.stub(:page).and_return(stub(:page, per: "blah"))
            current_store.should_receive(:filter_products_by_category).with("category").and_return(products)
            controller.stub(:current_store).and_return(current_store)
            get :index, {category_id: "category"}
          end
        end

        context "the category doesn't exist" do
          it "returns all the products" do
            current_store = Store.new
            current_store.active = true
            current_store.stub(:approved?).and_return(true)
            current_store.stub(:pending?).and_return(false)
            #current_store.should_receive(:filter_products_by_category).and_raise(Exception)
            controller.stub(:current_store).and_return(current_store)
            current_store.should_receive(:products).at_most(:twice).and_call_original
            get :index, {category_id: "category"}
          end
        end
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
