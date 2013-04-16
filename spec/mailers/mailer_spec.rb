require 'spec_helper'

describe Mailer do

  before(:each) do
    @customer = FactoryGirl.create(:customer, email: 'phyzikz@g.com' )
    @user = FactoryGirl.create(:user, customer_id: @customer.id)
  end

  it 'sends a welcome email' do
    email = Mailer.welcome_email(@user).deliver
    expect(ActionMailer::Base.deliveries).to_not be_empty
  end

  it 'sends an order confirmation email' do
    pending "not sure how to fix this test properly: Ask Katrina?"
    # order = FactoryGirl.create(:order, customer_id: @customer.id)
    # display = order_confirmation_path
    # display.stub!(:uuid).and_returns("randomstring-here-I-am")
    # email = Mailer.order_confirmation(@customer, order).deliver
    # expect(ActionMailer::Base.deliveries).to_not be_empty
  end
end
