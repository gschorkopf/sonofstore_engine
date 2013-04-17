class SessionsController < ApplicationController


  def new
  end

  def create
    session_params = params[:sessions]
    if Customer.find_by_email(session_params[:email])
      customer_id = Customer.find_by_email(session_params[:email]).id

      user = login(customer_id,
                   session_params[:password],
                   session_params[:remember_me]
                   )
      if user
        redirect_to session[:return_to] || profile_path, notice: 'Logged in!'
      else
        flash.alert = 'Username or password was invalid'
        redirect_to login_path
      end
    else
      redirect_to login_path, notice: "#{session_params[:email]} not on file"
    end
  end

  def destroy
    logout
    redirect_to root_url, notice: 'Logged out!'
  end
end
