require 'spec_helper'

describe Cart do
  context 'new' do
    it 'has items' do
      store = FactoryGirl.create(:store)
      product = FactoryGirl.create(:product, store_id: store.id)
      session = {}
      session[:cart] = {product.id => '2'}
      cart = Cart.new(session[:cart])
      expect(cart.session).to eq ({product.id => '2'})
    end
  end
end
