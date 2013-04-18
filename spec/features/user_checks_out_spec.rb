require 'spec_helper'

describe 'user_checks_out', type: :feature do

  def signup_user
    visit '/signup'
    fill_in "full_name", with: 'Maya Angelou'
    fill_in "email", with: 'poetry@poetry.com'
    fill_in "display_name", with: 'poet'
    fill_in "password", with: 'poet'
    fill_in "password_confirmation", with: 'poet'
    click_button "Sign Up"
  end

  before(:each) do
    @store = FactoryGirl.create(:store)
    @product = FactoryGirl.create(:product, store_id: @store.id)

    signup_user

    visit store_product_path(store_path: @store, id: @product.id)
    click_link_or_button 'Add to Cart'
    visit store_cart_path(@store)
    click_link_or_button 'Checkout'
  end

  context 'when they are already signed in' do
    context 'when they do not have ship/bill/cc info stored' do
      it 'they are prompted to fill out their info' do
        expect(page).to have_content('Shipping')
      end

      it 'once they enter their info, it takes them to order review' do
        fill_in 'shipping_address_street_address', with: '231 Main St'
        fill_in 'shipping_address_city', with: 'Honolulu'
        fill_in 'shipping_address_zip', with: '12345'
        fill_in 'shipping_address_state', with: 'Hawaii'

        fill_in 'billing_address_street_address', with: '231 Main St'
        fill_in 'billing_address_city', with: 'Honolulu'
        fill_in 'billing_address_zip', with: '12345'
        fill_in 'billing_address_state', with: 'Hawaii'

        fill_in 'credit_card_number', with: '4242424242424242'
        fill_in 'credit_card_expiration_month', with: '1'
        fill_in 'credit_card_expiration_year', with: '2015'
        fill_in 'credit_card_security_code', with: '111'

        save_and_open_page

        click_link_or_button 'submit_order_button'
        save_and_open_page
        expect(page).to have_content('Successfully created order!')
      end

    end

    context 'when they have shipping/billing/credit card info already saved' do
      it 'allows them to checkout without re-entering the info' do
        pending
      end
    end
  end

  context 'when they are not signed in' do
    #a) sign up for a new account during checkout
    #b) checkout as a guest
  end
  
end
