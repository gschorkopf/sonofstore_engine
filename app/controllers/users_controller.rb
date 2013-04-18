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

      redirect_to session[:return_to] || root_path, notice: 'Logged in!'
    elsif @signup.message
      redirect_to signup_path, alert: "Email already exists"
    else
      redirect_to signup_path, alert: "#{formated_errors}"
    end
  end

  def formated_errors
    if user_errors && customer_errors
      "#{customer_errors}, #{user_errors}"
    elsif user_errors
      "#{user_errors}"
    else
      "#{customer_errors}"
    end
  end

  def user_errors
    if @signup.user.errors.messages[:password]
      @signup.user.errors.messages[:password][0].slice!("passwords ")
      "Password #{@signup.user.errors.messages[:password][0]}"
    end
  end

  def customer_errors
    errors = []
    if @signup.customer.errors.messages[:full_name]
      errors << "Please enter a full name"
    end
    if @signup.customer.errors.messages[:email]
      errors << "Email is invalid"
    end
    unless errors == []
      "#{errors.join(", ")}"
    end
  end

  def signup
    @user = User.new
  end

  def update
    @update = Signup.update(params)

    if @update == true
      redirect_to profile_path,
        :notice => "Successfully updated account"
    else
      redirect_to "/profile",
        notice: @update[:password].pop
    end
  end

  def show
    if current_user.present?
      @user = User.find(current_user.id)

      @customer = @user.customer
      @orders = @user.customer.orders
      @stores = @user.stores
      @pending_stores = @stores.order('name ASC').where(approval_status: 'pending')
      @approved_stores = @stores.order('name ASC').where(approval_status: 'approved')
      @disapproved_stores = @stores.order('name ASC').where(approval_status: 'disapproved')
    else
      redirect_to login_path, alert: 'Please log in!'
    end
  end
end
