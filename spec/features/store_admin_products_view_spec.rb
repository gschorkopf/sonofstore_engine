require 'spec_helper'

describe 'the admin products view', type: :feature do
  before(:each) do
    @store = FactoryGirl.create(:store, approval_status: 'approved', active: true)
    customer = FactoryGirl.create(:customer, email: 'teeny@tiny.com')
    store_admin = FactoryGirl.create(:store_admin, customer_id: customer.id)
    user_role = UserRole.new(user_id: store_admin.id, store_id: @store.id)
    user_role.role = 'store_admin'
    user_role.save

    visit login_path
    fill_in 'sessions_email', with: 'teeny@tiny.com'
    fill_in 'sessions_password', with: 'password'
    click_button 'Login'
    visit store_admin_products_path(@store)
  end

  it 'should have a title' do
    expect(page).to have_selector('h1', text: 'Products')
  end

  it 'should have a create product button' do
    expect(page).to have_button('create_new_product')
  end

  it 'creates a new product with valid input' do
    click_button 'create_new_product'
    fill_in "Title", with: 'something'
    fill_in "Description", with: 'blah blah blah'
    fill_in "Price", with: '1.99'
    choose('active')
    click_button "Submit"
    expect(current_path).to eq store_admin_products_path(@store)
  end

  it 'fails to create a new product with invalid input' do
    click_button 'create_new_product'
    fill_in "Description", with: 'blah blah blah'
    fill_in "Price", with: '1.99'
    choose('active')
    click_button "Submit"
    expect(page).to have_content("can't be blank")
  end

  context 'editing, destroying, and retiring/activating products' do
    before(:each) do
      @store = FactoryGirl.create(:store)
      @product = FactoryGirl.create(:product, store_id: @store.id)
    end

    it 'edits a product correctly' do
      visit edit_store_admin_product_path(store_path: @store, id: @product)
      fill_in "Title", with: "whateveryouwant"
      click_button "Submit"
      expect(current_path).to eq store_admin_products_path(@store)
    end

    it 'edits a product with incorrect info' do
      visit edit_store_admin_product_path(store_path: @store, id: @product)
      fill_in "Title", with: ""
      click_button "Submit"
      expect(page).to have_content("can't be blank")
    end

    it 'can destroy an existing product' do
      page.driver.submit :delete, store_admin_product_path(store_path: @store, id: @product), {}
      expect(Product.all).to eq []
    end

    it 'can retire an active product' do
      page.driver.post toggle_status_store_admin_product_path(store_path: @store, id: @product)
      expect(@product.status).to eq 'active'
    end

    it 'can activate a retired product' do
      page.driver.post toggle_status_store_admin_product_path(store_path: @store, id: @product)
      expect(@product.status).to eq 'active'
    end
  end
end

