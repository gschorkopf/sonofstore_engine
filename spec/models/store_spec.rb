require 'spec_helper'

describe Store do
  it 'has a valid factory' do
    expect(FactoryGirl.build(:store)).to be_valid
  end

  it 'is not valid without a name' do
    store = FactoryGirl.build(:store, name: '')
    expect(store.valid?).to be_false
  end

  it 'is not valid without a path' do
    store = FactoryGirl.build(:store, path: '')
    expect(store.valid?).to be_false
  end

  it 'is not valid without a description' do
    store = FactoryGirl.build(:store, description: '')
    expect(store.valid?).to be_false
  end

  context 'given a previous store with same info was declined' do
    it 'can be valid' do
    pending
    end
  end

end
