require File.dirname(__FILE__) + '/../spec_helper'

describe Customer do
 it 'is invalid without an email' do
    expect(FactoryGirl.build(:customer, email: nil)).to_not be_valid
  end

  it 'is invalid with a duplicate email' do
    FactoryGirl.create(:customer)
    expect(FactoryGirl.build(:customer)).to_not be_valid
  end

  it 'is invalid without a full name' do
    expect(FactoryGirl.build(:customer, full_name: '')).to_not be_valid
  end
end
