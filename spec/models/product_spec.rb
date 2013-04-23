require File.dirname(__FILE__) + '/../spec_helper'

describe Product do
  before(:each) do
    @store = FactoryGirl.create(:store)
    @product = FactoryGirl.build(:product, store_id: @store.id)
  end

  it 'has a valid factory' do
    expect(@product).to be_valid
  end

  it 'is invalid without a title' do
    @product.title = ''
    expect(@product).to_not be_valid
  end

  it 'is invalid without a description' do
    @product.description = ''
    expect(@product).to_not be_valid
  end

  it 'is invalid without a store id' do
    #this is failing because it cannot do a custom validation without a store id
    @product.store_id = ''
    expect(@product.valid?).to be_false
  end

  it 'is invalid if title already exists in the same store' do
    product2 = FactoryGirl.build(:product, store_id: @store.id)
    expect(product2.valid?).to be_false
  end

  it 'is invalid if title already exists (case insensitive) in the same store' do
    FactoryGirl.create(:product, title: 'ITCHY Sweater', store_id: @store.id)
    product = FactoryGirl.build(:product, store_id: @store.id)
    expect(product.valid?).to be_false
  end

  it 'is valid if the title already exists in a different store' do
    @product.save
    store2 = FactoryGirl.create(:store, name: 'KimChi Caravan', path: 'kimchi-caravan')
    product2 = FactoryGirl.create(:product, title: 'Itchy Sweater', store_id: store2.id)
    expect(product2).to be_valid
  end

  it 'is invalid without a price' do
    @product.price = nil
    expect(@product).to_not be_valid
  end

  it 'is invalid without a price greater than 0' do
    @product.price = 0
    expect(@product).to_not be_valid
  end

  it 'is only valid with two or less decimal points' do
    expect(FactoryGirl.build(:product, store_id: @store.id, price: 0.123)).to_not be_valid
    expect(FactoryGirl.build(:product, store_id: @store.id, price: 0.10)).to be_valid
    expect(FactoryGirl.build(:product, store_id: @store.id, price: 0.1)).to be_valid
    expect(FactoryGirl.build(:product, store_id: @store.id, price: 2)).to be_valid
  end

  it 'is invalid without a status' do
    @product.status = nil
    expect(@product).to_not be_valid
  end

  it 'is invalid with a status other than active or retired' do
    expect(FactoryGirl.build(:product, store_id: @store.id, status: 'active')).to be_valid
    expect(FactoryGirl.build(:product, store_id: @store.id, status: 'retired')).to be_valid
    expect(FactoryGirl.build(:product, store_id: @store.id, status: 'something')).to_not be_valid
  end

  it 'has the ability to be assigned to multiple categories' do
    nicknacks = FactoryGirl.create(:category, title: 'nicknacks', store_id: @store.id)
    superheroes = FactoryGirl.create(:category, title: 'superheroes', store_id: @store.id)
    product = FactoryGirl.create(:product, store_id: @store.id, categories: [nicknacks, superheroes])
    expect(product.categories.count).to eq 2
  end

  describe '.toggle_status' do
    context 'on an active product' do
      it 'sets the status from active to retired' do
        product = FactoryGirl.create(:product, store_id: @store.id, status: 'active')
        product.toggle_status
        expect(product.status).to eq 'retired'
      end
    end

    context 'on a retired product' do
      it 'sets the status to active' do
        product = FactoryGirl.create(:product, store_id: @store.id, status: 'retired')
        product.toggle_status
        expect(product.status).to eq 'active'
      end
    end
  end
end
