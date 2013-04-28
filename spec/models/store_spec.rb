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
    declined_store = FactoryGirl.create(:store, approval_status: 'declined')
    expect(FactoryGirl.build(:store).valid?).to be_true
    end
  end

  describe '#filter_products_by_category' do
    context 'a category exists' do
      it "should return an array of products that have that category" do
      store = FactoryGirl.build(:store, name:"store", path:"storepath")
      category1 = store.categories.build(title: "category 1")
      category2 = store.categories.build(title: "category 2")
      store.save!

      product1 = FactoryGirl.create(:product, title: "p1", store_id: store.id)
      product1.categories << category1

      product2 = FactoryGirl.create(:product, title: "p2", store_id: store.id)
      product2.categories << category1
      product2.categories << category2

      categories = store.filter_products_by_category(category2.id)
      expect(categories).to eq [product2]
      end
    end

  end

end
