require 'spec_helper'

describe BillingAddress do

  it 'has a valid factory' do
    expect(FactoryGirl.build(:billing_address)).to be_valid
  end

  it 'is not valid without proper attributes' do
    expect(FactoryGirl.build(:billing_address, street_address: nil)).to_not be_valid
    expect(FactoryGirl.build(:billing_address, city: nil)).to_not be_valid
    expect(FactoryGirl.build(:billing_address, zip: nil)).to_not be_valid
    expect(FactoryGirl.build(:billing_address, state: nil)).to_not be_valid
  end

  it 'is not valid with a zipcode of less than 5 digits' do
    expect(FactoryGirl.build(:billing_address, zip: '1234')).to_not be_valid
  end

  it 'is not valid with a zipcode of more than 5 digits' do
    expect(FactoryGirl.build(:billing_address, zip: '1234567')).to_not be_valid
  end
end
