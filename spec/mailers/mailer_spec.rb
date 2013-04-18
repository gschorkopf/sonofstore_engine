require 'spec_helper'

describe Mailer do

  before(:each) do
    @customer = FactoryGirl.create(:customer, email: 'phyzikz@g.com' )
    @user = FactoryGirl.create(:user, customer_id: @customer.id)
    @store = FactoryGirl.create(:store)

    customer2 = FactoryGirl.create(:customer)
    @store_admin = FactoryGirl.create(:store_admin, customer_id: customer2.id)
    user_role = UserRole.new(user_id: @store_admin.id, store_id: @store.id)
    user_role.role = 'store_admin'
    user_role.save
  end

  it 'sends a welcome email' do
    email = Mailer.welcome_email(@user).deliver
    expect(ActionMailer::Base.deliveries).to_not be_empty
  end

  it 'sends an order confirmation email' do
    order = FactoryGirl.create(:order, customer_id: @customer.id)
    display = order_confirmation_path(order)
    display.stub!(:uuid).and_return("randomstring-here-I-am")

    email = Mailer.order_confirmation(@customer, order).deliver
    expect(ActionMailer::Base.deliveries).to_not be_empty
  end

  it 'sends a store_admin_welcome email' do
    email = Mailer.store_admin_welcome_email(@store_admin, @store).deliver
    expect(ActionMailer::Base.deliveries).to_not be_empty
  end

  it 'sends a sign up as admin email' do
    email = 'tiny@teeny.com'
    Mailer.sign_up_as_admin(email, @store).deliver
    expect(ActionMailer::Base.deliveries).to_not be_empty
  end

  it 'sends a store stocker welcome email' do
    Mailer.store_stocker_welcome_email(@user, @store).deliver
    expect(ActionMailer::Base.deliveries).to_not be_empty
  end

  it 'sends a sign up as stocker email' do
    email = 'tiny@teeny.com'
    Mailer.sign_up_as_stocker(email, @store).deliver
    expect(ActionMailer::Base.deliveries).to_not be_empty
  end

  it 'sends a remove admin from store email' do
    Mailer.remove_admin_from_store(@user, @store).deliver
    expect(ActionMailer::Base.deliveries).to_not be_empty
  end

  it 'sends a remove stocker from store email' do
    Mailer.remove_stocker_from_store(@user, @store).deliver
    expect(ActionMailer::Base.deliveries).to_not be_empty
  end
end
