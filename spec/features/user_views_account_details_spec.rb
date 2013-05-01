require 'spec_helper'

describe 'user account detail view' do
  context 'when the user is logged in' do
    before(:each) do
      customer = create(:customer, email: 'dboone54@yahoo.com')
      @user = create(:user, customer_id: customer.id)
      visit '/login'
      fill_in 'sessions_email', with: 'dboone54@yahoo.com'
      fill_in 'sessions_password', with: 'password'
      click_button 'Login'
    end

    it 'display the main page of their account details' do
      visit 'profile'
      expect(page).to have_content("Daniel Boone's Account")
    end

    it 'cannot update their profile with incorrect information' do
      visit 'profile'
      click_link_or_button 'Edit Account'
      fill_in 'user[password]', with: 't'
      click_button 'Update'
      expect(page).to have_content("not match")
    end

    context 'when they click the link to their order history page' do
      it 'takes them to their order history page' do
        visit 'profile'
        click_link "Order History"
        expect(page).to have_content("Order History")
      end
    end
  end
end
