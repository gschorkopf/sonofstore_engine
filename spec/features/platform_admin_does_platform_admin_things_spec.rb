require 'spec_helper'

describe 'the platform admin does platform admin things', type: :feature do
  before(:each) do
    #creating a pending store and a platform admin
    @store1 = FactoryGirl.create(:store, approval_status: 'pending')
    customer = FactoryGirl.create(:customer, email: 'crockett@hotmail.com')
    @platform_admin = FactoryGirl.create(:platform_admin, customer_id: customer.id)

    #Log in Platform Admin
    visit '/login'
    fill_in 'sessions_email', with: 'crockett@hotmail.com'
    fill_in 'sessions_password', with: 'password'
    click_button 'Login'
  end

  it 'views the store management page' do
    visit admin_stores_path
    expect(page).to have_content("Pending")
    expect(Store.where(approval_status: 'pending').count).to eq 1
  end


  context 'given there is a pending store' do
    it 'can accept a pending store' do
      visit admin_stores_path
      click_link_or_button "approve_store"

      # create customer, test elsewhere?
      expect(Store.where(approval_status: 'pending').count).to eq 0
      expect(Store.where(approval_status: 'approved').count).to eq 1
    end

    it 'can decline a pending store' do
      visit admin_stores_path
      click_link_or_button "decline_store"
      expect(Store.where(approval_status: 'pending').count).to eq 0
      expect(Store.where(approval_status: 'declined').count).to eq 1
    end
  end

  context 'working with an approved store' do
    context 'when a store is disabled' do
      it 'can make a disabled store enabled' do
        @store1.approval_status = 'approved'
        @store1.active = 'false'
        @store1.save

        visit admin_stores_path
        click_link_or_button "enable_store"
        expect(Store.where(active: true).count).to eq 1
        expect(Store.where(active: false).count).to eq 0
      end
    end

    context 'when a store is enabled' do
      it 'can make an accepted store disabled' do
        @store1.approval_status = 'approved'
        @store1.active = 'true'
        @store1.save

        visit admin_stores_path
        click_link_or_button "disable_store"
        expect(Store.where(active: false).count).to eq 1
        expect(Store.where(active: true).count).to eq 0
      end

      it 'can click a link to be taken to a view of the store' do
        @store1.approval_status = 'approved'
        @store1.active = true #enabled
        @store1.save

        visit admin_stores_path
        click_link_or_button 'visit_store_admin_page'
        expect(current_path).to eq store_admin_path(@store1)
      end
    end
  end
end
