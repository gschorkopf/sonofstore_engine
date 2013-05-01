require File.dirname(__FILE__) + '/../spec_helper'

describe Order do
  before(:each) do
    @customer = FactoryGirl.create(:customer)
  end

  it 'has a valid factory' do
    expect(FactoryGirl.build(:order, customer: @customer)).to be_valid
  end

  it 'is invalid without a customer' do
    expect(FactoryGirl.build(:order, customer: nil)).to_not be_valid
  end

  it 'is invalid without a valid status' do
    expect(FactoryGirl.build(:order, customer: @customer, status: 'pending')).to be_valid
    expect(FactoryGirl.build(:order, customer: @customer, status: 'cancelled')).to be_valid
    expect(FactoryGirl.build(:order, customer: @customer, status: 'paid')).to be_valid
    expect(FactoryGirl.build(:order, customer: @customer, status: 'shipped')).to be_valid
    expect(FactoryGirl.build(:order, customer: @customer, status: 'returned')).to be_valid
    expect(FactoryGirl.build(:order, customer: @customer, status: nil)).to_not be_valid
    expect(FactoryGirl.build(:order, customer: @customer, status: 'abracadabra')).to_not be_valid
  end
end
