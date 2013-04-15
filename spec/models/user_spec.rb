require File.dirname(__FILE__) + '/../spec_helper'

describe User do
  before(:each) do
    @customer = FactoryGirl.create(:customer)
  end

  it 'has a valid factory' do
    expect(FactoryGirl.create(:user, customer_id: @customer.id )).to be_valid
  end

  it 'is invalid without a password' do
    expect(FactoryGirl.build(:user, customer_id: @customer.id, password: '')).to_not be_valid
  end

  it 'is invalid without a customer_id' do
    expect(FactoryGirl.build(:user, password: '')).to_not be_valid
  end

  it 'is invalid if display name is not between 2-32 chars if it exists' do
    expect(FactoryGirl.build(:user, customer_id: @customer.id, display_name: 'p')).to_not be_valid
    expect(FactoryGirl.build(:user, customer_id: @customer.id, display_name: 'p' * 33)).to_not be_valid
    expect(FactoryGirl.build(:user, customer_id: @customer.id, display_name: 'p' * 32)).to be_valid
  end
end
