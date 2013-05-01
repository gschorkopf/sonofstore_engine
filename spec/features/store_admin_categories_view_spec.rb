require 'spec_helper'

describe 'the admin categories view', type: :feature do
  before(:each) do
    @store = create(:store)
    customer = create(:customer, email: 'teeny@tiny.com')
    store_admin = create(:store_admin, customer_id: customer.id)
    role = UserRole.new(user_id: store_admin.id, store_id: @store.id)
    role.role = 'store_admin'
    role.save

    visit login_path
    fill_in 'sessions_email', with: 'teeny@tiny.com'
    fill_in 'sessions_password', with: 'password'
    click_button 'Login'
    visit store_admin_categories_path(@store)
  end

  it 'should have a title and New Category Button' do
    expect(page).to have_selector('h1', text: 'Categories')
    expect(page).to have_button('New Category')
  end

  context 'when a category exists' do
    before(:each) do
      click_button "New Category"
      fill_in 'Title', with: 'mah things'
      click_button "Submit"
    end

    it 'creates a new category with valid input' do
      expect(current_path).to eq store_admin_categories_path(@store)
    end

    it 'rejects invalid category input' do
      click_button "New Category"
      fill_in 'Title', with: 'mah things'
      click_button "Submit"
      expect(page).to have_content "has already been taken"
    end

    it 'edits a category with valid input' do
      click_link "edit"
      fill_in "Title", with: 'gooey'
      click_button "Submit"
      expect(current_path).to eq store_admin_categories_path(@store)
    end
  end
end
