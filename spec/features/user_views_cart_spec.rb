require 'spec_helper'

describe 'the user cart view' do
  context 'when there are no items in the cart' do
    it 'displays a message that the cart is empty' do
      visit cart_path
      expect(page).to have_content('empty')
    end
  end

  context 'when there are items in the cart' do
    before(:each) do
      @store = FactoryGirl.create(:store)
      @product = FactoryGirl.create(:product, store_id: @store.id)
      visit store_product_path(store_path: @store, id: @product.id)
      click_link_or_button 'Add to Cart'
      visit cart_path
    end

    it 'shows the cart with items quantities and prices' do
      expect(page).to have_content('Total')
    end

    context 'and the user empties their cart' do
      it 'then the cart gets emptied' do
        visit store_product_path(store_path: @store, id: @product.id)
        click_button 'Add to Cart'
        visit cart_path
        click_link 'Remove'
        expect(page).to have_content('Your cart is empty')
      end
    end

    context 'the user wants to remove an item from the cart' do
      it 'gets removed' do
        click_button 'Empty Cart'
        expect(current_path).to eq root_path
      end
    end

    context 'the user wants to remove one item from the cart' do
      it 'removes one item' do
        product2 = FactoryGirl.create(:product, store_id: @store.id, title: 'coolthings')
        visit store_product_path(store_path: @store, id: product2.id)
        click_button "Add to Cart"
        visit cart_path
        fill_in  'carts_quantity', with: '0'
        click_button 'Update'
        expect(current_path).to eq cart_path
      end
    end
  end

end
