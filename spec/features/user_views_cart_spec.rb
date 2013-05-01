require 'spec_helper'

describe 'the user cart view' do
  context 'when there are no items in the cart' do
    it 'displays a message that the cart is empty' do
      @store = create(:store)
      visit store_cart_path(@store)
      expect(page).to have_content('empty')
    end
  end

  context 'when there are items in the cart' do
    before(:each) do
      @store = create(:store)
      @product = create(:product, store_id: @store.id)
      visit store_product_path(store_path: @store, id: @product.id)
      click_link_or_button 'Add to Cart'
      visit store_cart_path(@store)
    end

    it 'shows the cart with items quantities and prices' do
      expect(page).to have_content('Total')
    end

    context 'and the user empties their cart' do
      it 'then the cart gets emptied' do
        visit store_product_path(store_path: @store, id: @product.id)
        click_button 'Add to Cart'
        visit store_cart_path(@store)
        click_link 'Remove'
        expect(page).to have_content('Your cart is empty')
      end
    end

    context 'the user wants to remove an item from the cart' do
      it 'gets removed' do
        visit store_cart_path(@store)
        click_link_or_button 'Remove'
        expect(current_path).to eq store_cart_path(@store)
      end
    end

    context 'the user wants to remove one item from the cart' do
      it 'removes one item' do
        product2 = create(:product, store_id: @store.id, title: 'coolthings')
        visit store_product_path(store_path: @store, id: product2.id)
        click_button "Add to Cart"
        visit store_cart_path(@store)
        fill_in  'carts_quantity', with: '0'
        click_button 'Update'
        expect(current_path).to eq store_cart_path(@store)
      end
    end
  end

end
