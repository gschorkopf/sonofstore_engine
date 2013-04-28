require File.dirname(__FILE__) + '/../spec_helper'

describe Customer do
 it 'is invalid without an email' do
    expect(FactoryGirl.build(:customer, email: nil)).to_not be_valid
  end

  it 'is invalid with a duplicate email' do
    FactoryGirl.create(:customer, email: 'what@what.com')
    expect(FactoryGirl.build(:customer, email: 'what@what.com')).to_not be_valid
  end

  it 'is invalid without a full name' do
    expect(FactoryGirl.build(:customer, full_name: '')).to_not be_valid
  end

  describe 'best_display_name' do
    context 'when a customer has a user and a display name' do
      it 'uses their display name' do
        customer = create(:customer)
        user = create(:user, customer: customer)
        expect(customer.best_display_name).to eq customer.user.display_name
      end
    end

    context 'when a customer has a user but no display name' do
      it 'generates a random display name' do
        customer = create(:customer)
        user = create(:user, customer: customer, display_name: nil)
        expect(customer.best_display_name).to_not eq customer.user.display_name
      end
    end

      context 'when a customer does not have a user' do
        it 'generates a random display name' do
          pending 'whats a better way to test randomness?'
           # customer1 = create(:customer)
           # customer2 = create(:customer, email: 'hoo@hee.com')
           # expect(customer1.best_display_name).to_not eq customer2.best_display_name
        end
      end
  end

  describe 'purchased_product?' do
    context "when a user purchased the product" do
      it "returns true when given the product id" do
        order_item1 = FactoryGirl.create(:order_item)
        customer = order_item1.order.customer
        product = order_item1.product
        expect(customer).to have_purchased_product(product.id)
      end

    end

    context "when the user has not purchased the product" do

      it "returns false when given a product id" do
        order_item1 = FactoryGirl.create(:order_item)
        customer = order_item1.order.customer
        product = FactoryGirl.create(:product)
        expect(customer).to_not have_purchased_product(product.id)
      end
    end
  end
end
