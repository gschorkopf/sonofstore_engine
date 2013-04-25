class Admin::StockersController < ApplicationController
  before_filter :require_admin

  def new
    @store = current_store
    @user = User.new
  end

  def create
    email = params[:user][:customers][:email]
    @customer = Customer.find_by_email(email)
    @store = current_store

    if @customer
      @user = User.find_by_customer_id(@customer.id)
      ur = UserRole.create(store_id: @store.id, user_id: @user.id)
      ur.role = "stocker"
      ur.save
      Mailer.store_stocker_welcome_email(@user, @store).deliver
      redirect_to store_admin_path(@store), notice: "Stocker added!"
    else
      Mailer.sign_up_as_stocker(email, @store).deliver
      redirect_to store_admin_path(@store),
      notice: "This person is not currently registered with Ballmer's DoSE.  A welcome email has been sent on your behalf."
    end
  end
end
