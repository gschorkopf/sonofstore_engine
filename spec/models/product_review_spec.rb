require 'spec_helper'

describe ProductReview do
  it 'has a valid factory' do
    expect(FactoryGirl.build(:product_review)).to be_valid
  end

  it 'is valid without a comment' do
    expect(FactoryGirl.build(:product_review, comment: nil)).to be_valid
  end

  it 'is not valid without a customer id' do
    expect(FactoryGirl.build(:product_review, customer_id: nil)).to_not be_valid
  end

  it 'is not valid without a product id' do
    expect(FactoryGirl.build(:product_review, product_id: nil)).to_not be_valid
  end
end
