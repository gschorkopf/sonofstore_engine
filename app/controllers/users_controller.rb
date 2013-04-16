class UsersController < ApplicationController
  def new
    @user = User.new
   end

  def create
    @signup = Signup.new(params)

    if @signup.success?

      Mailer.welcome_email(@signup.user).deliver
      # Resque.enqueue(IntroMailer, @user.id)

      auto_login(@signup.user)
      #redirect_to root_url, :notice => "Welcome, #{@user.full_name}"
      redirect_to session[:return_to] || root_path, notice: 'Logged in!'
    else
      redirect_to signup_path, notice: "Invalid Attributes"
    end
  end

  def signup
    @user = User.new
  end

  def update
    @user = current_user
    if @user.update_attributes(params[:user])
      redirect_to profile_path,
      :notice => "Successfully updated account"
    else
      render :action => 'show'
    end
  end

  def show
    if current_user.present?
      @user = User.find(current_user.id)

      @customer = @user.customer
      @orders = @user.customer.orders
      @pending_stores = @user.stores.order('name ASC').where(approval_status: 'pending')
      @approved_stores = @user.stores.order('name ASC').where(approval_status: 'approved')
      @disapproved_stores = @user.stores.order('name ASC').where(approval_status: 'disapproved')
    else
      redirect_to login_path, alert: 'Please log in!'
    end
  end
end
