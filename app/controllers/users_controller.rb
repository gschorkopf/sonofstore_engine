class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])

    if @user.save
      Resque.enqueue(IntroMailer, @user.id)
      auto_login(@user)
      #redirect_to root_url, :notice => "Welcome, #{@user.full_name}"
      redirect_to session[:return_to] || root_path, notice: 'Logged in!'
    else
      render :action => 'new'
    end
  end

  def update
    @user = current_user
    if @user.update_attributes(params[:user])
      redirect_to account_profile_path,
      :notice => "Successfully updated account"
    else
      render :action => 'show'
    end
  end

  def show
    if current_user.present?
      @user = User.find(current_user.id)
      @orders = @user.orders
    else
      redirect_to root_url
    end
  end
end
