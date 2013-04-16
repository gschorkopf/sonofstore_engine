require File.dirname(__FILE__) + '/../spec_helper'

describe Product do
  before(:each) do
    @store = FactoryGirl.create(:store)
  end

  it 'has a valid factory' do
    product = FactoryGirl.build(:product, store_id: @store.id)
    expect(product).to be_valid
  end

  it 'is invalid without a title' do
    expect(FactoryGirl.build(:product, store_id: @store.id, title: '')).to_not be_valid
  end

  it 'is invalid without a description' do
    expect(FactoryGirl.build(:product, store_id: @store.id, description: '')).to_not be_valid
  end

  it 'is invalid without a store id' do
    expect(FactoryGirl.build(:product, store_id: '').valid?).to be_false
  end

  it 'is invalid if title already exists in the same store' do
    FactoryGirl.create(:product, store_id: @store.id)
    product = FactoryGirl.build(:product, store_id: @store.id)
    expect(product.valid?).to be_false
  end

  it 'is invalid if title already exists (case insensitive) in the same store' do
    #fix test when case insensitivy is updated
    FactoryGirl.create(:product, title: 'ITCHY Sweater', store_id: @store.id)
    product = FactoryGirl.build(:product, store_id: @store.id)
    expect(product.valid?).to be_false
  end

  it 'is valid if the title already exists in a different store' do
    pending
  end

  it 'is invalid without a price' do
    expect(FactoryGirl.build(:product, store_id: @store.id, price: nil)).to_not be_valid
  end

  it 'is invalid without a price greater than 0' do
    expect(FactoryGirl.build(:product, store_id: @store.id, price: 0)).to_not be_valid
  end

  it 'is only valid with two or less decimal points' do
    expect(FactoryGirl.build(:product, store_id: @store.id, price: 0.123)).to_not be_valid
    expect(FactoryGirl.build(:product, store_id: @store.id, price: 0.10)).to be_valid
    expect(FactoryGirl.build(:product, store_id: @store.id, price: 0.1)).to be_valid
    expect(FactoryGirl.build(:product, store_id: @store.id, price: 2)).to be_valid
  end

  it 'is invalid without a status' do
    expect(FactoryGirl.build(:product, store_id: @store.id, status: nil)).to_not be_valid
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

  it "includes Paperclip correctly" do
    pending "fix when we do paperclip, or write a different test"
    example = Product.new :image => File.new(Rails.root + 'spec/fixtures/images/rails.png')
    expect(example.image_file_name).to eq 'rails.png'
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
