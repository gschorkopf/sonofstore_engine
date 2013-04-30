require File.dirname(__FILE__) + '/../spec_helper'

describe ProductsController do
  describe 'GET #index' do

    let(:current_store) {Store.new}

    before do
      controller.stub(:current_store).and_return(current_store)
    end

    context 'given a store that is active' do

      before do
        current_store.stub(:inactive?).and_return(false)
        current_store.stub(:pending?).and_return(false)
      end

      it "index action should render index template" do
        pending 'need to figure out how to create a current_store'
        get :index
        response.should render_template(:index)
      end

      context "a category is added as a param" do

        let(:expected_params) {{category_id: "category", sorted_by: nil}}

        context "the category exists" do

          it "filters products by category" do
            products = [Product.new]
            products.stub(:page)
              .and_return(stub(:page, per: "blah"))

            current_store.should_receive(:search)
              .with(expected_params)
              .and_return(products)

            get :index, {category_id: "category"}
          end
        end

        context "the category doesn't exist" do
          it "returns all the products" do
            current_store.should_receive(:search)
              .with(expected_params)
              .and_raise(::ActiveRecord::RecordNotFound)

            current_store.should_receive(:search)
              .with(sorted_by: nil)
              .and_call_original

            get :index, {category_id: "category"}
          end
        end
      end

      context "want products sorted by highest average rating" do
        it "returns sorted products" do
            products = [Product.new]
            products.stub(:page).and_return(stub(:page, per: "blah"))

            current_store.should_receive(:search)
              .with(category_id: nil, sorted_by: "average_rating")
              .and_return(products)

          get :index, {sorted_by: "average_rating"}
        end
      end

    end

    context 'given a store that is pending' do
      it 'index action should provide a 404 error' do
        current_store.stub(:pending?).and_return(true)
        get :index
        expect(response.status).to eq 404
      end
    end

    context 'given a store does not exist' do
      it 'index action should provide a 404 error' do
        controller.stub(:current_store).and_return(nil)
        get :index
        expect(response.status).to eq 404
      end
    end
  end
end
