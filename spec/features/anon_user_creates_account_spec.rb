require 'spec_helper'

describe 'new user creates and edits account' do
  def signup_user
    visit '/signup'
    fill_in "full_name", with: 'Maya Angelou'
    fill_in "email", with: 'poetry@poetry.com'
    fill_in "display_name", with: 'poet'
    fill_in "password", with: 'poet'
    fill_in "password_confirmation", with: 'poet'
    click_button "Sign Up"
  end

  describe 'registering a new account' do
    before(:each) do
      signup_user
    end

    context 'when they provide unique login info' do
      it 'creates a new user account' do
        expect(page).to have_content "Welcome"
        expect(current_path).to eq root_path
      end
    end

    context 'when they provide non-unique login info for registration' do
      it 'returns an error message' do
        visit '/signup'
        fill_in "full_name", with: 'IMPOSTER'
        fill_in "email", with: 'poetry@poetry.com'
        fill_in "display_name", with: 'poet'
        fill_in "password", with: 'poet'
        fill_in "password_confirmation", with: 'poet'
        click_button "Sign Up"
        expect(page).to have_content "Email already exists"
        expect(current_path).to eq signup_path
      end
    end
  end

  describe 'signing in and out of account' do
    before(:each) do
      signup_user
    end

    it 'allows them to log out of their account' do
      visit login_path
      fill_in "Email", with: 'poetry@poetry.com'
      fill_in "Password", with: "poet"
      click_button "Login"
      expect(current_path).to eq profile_path
      click_link_or_button "Logout"
      expect(current_path).to eq root_path
    end

    it 'rejects incorrect login info on signin' do
      visit login_path
      fill_in "Email", with: 'poetry@poetry.com'
      fill_in "Password", with: "whatsmypassword"
      click_button "Login"
      expect(current_path).to eq login_path
      expect(page).to have_content 'invalid'
    end
  end

  it 'edits the account with valid input' do
    signup_user
    visit login_path
    fill_in "Email", with: 'poetry@poetry.com'
    fill_in "Password", with: "poet"
    click_button "Login"
    visit profile_path
    fill_in "user[display_name]", with: 'Maya'

    click_button "Update"
    expect(current_path).to eq profile_path
    expect(page).to have_content "updated account"
  end
end
