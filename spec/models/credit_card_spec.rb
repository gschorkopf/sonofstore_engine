require 'spec_helper'

describe CreditCard do
  before(:each) do
    @customer = FactoryGirl.create(:customer)
  end
  it 'has a valid factory' do
    expect(FactoryGirl.create(:credit_card, customer: @customer)).to be_valid
  end

  it 'is not valid with missing attributes' do
   expect(FactoryGirl.build(:credit_card, customer: nil)).to_not be_valid
   expect(FactoryGirl.build(:credit_card, customer: @customer, number: '')).to_not be_valid
   expect(FactoryGirl.build(:credit_card, customer: @customer, expiration_month: '')).to_not be_valid
   expect(FactoryGirl.build(:credit_card, customer: @customer, expiration_year: '')).to_not be_valid
   expect(FactoryGirl.build(:credit_card, customer: @customer, security_code: '')).to_not be_valid
  end

  it 'is not valid with a cc number more than or less than 16 digits' do
    expect(FactoryGirl.build(:credit_card, customer: @customer, number: '4242424242424242444444')).to_not be_valid
    expect(FactoryGirl.build(:credit_card, customer: @customer, number: '424242424')).to_not be_valid
  end
end
