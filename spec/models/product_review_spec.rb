require 'spec_helper'

describe ProductReview do
  it 'has a valid factory' do
    expect(FactoryGirl.build(:product_review)).to be_valid
  end

  it 'is valid without a comment' do
    expect(FactoryGirl.build(:product_review, comment: nil)).to be_valid
  end
end
