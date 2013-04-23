class Signup
  attr_reader :customer, :user, :message


  def initialize(params)
    if Customer.find_by_email(params[:email]) != nil && Customer.find_by_email(params[:email]).user != nil
      @customer = Customer.new
      @user = User.new
      @message = "Email already exists"
    else
      @customer = Customer.create(email: params[:email])
      @customer.full_name = params[:full_name]
      @customer.save

      @user = User.find_or_create_by_customer_id(@customer.id)
      @user.update_attributes(password: params[:password],
                 password_confirmation: params[:password_confirmation])
      unless params[:display_name].blank?
        @user.update_attributes(display_name: params[:display_name])
      end
    end
    if Customer.find_by_email(params[:email]) != nil && Customer.find_by_email(params[:email]).user == nil
      @customer = Customer.find_by_email(params[:email])
      @customer.full_name = params[:full_name]
      @customer.save
      @user = User.create(password: params[:password],
             password_confirmation: params[:password_confirmation],
                      display_name: params[:display_name],
                       customer_id: @customer.id)
    end
  end

  def self.update(params)
    @user = User.find(params[:id])
    @customer = Customer.find(@user.customer_id)
    errors = @user.errors.messages.merge(@customer.errors.messages)
    
    if errors.empty?
      return true
    else
      return errors
    end 

    if params[:display_name] != @user.display_name
      @user.update_attributes(display_name: params[:display_name])
      return true
    end
    
    if params[:full_name] != @customer.full_name || params[:email] != @customer.email
      @customer.update_attributes(email: params[:email])
      @customer.update_attributes(full_name: params[:full_name])
      return true
    end

    unless params[:password].blank? && params[:password_confirmation].blank?
      @user.update_attributes(password: params[:password],
                 password_confirmation: params[:password_confirmation])
    end
  end

  def success?
    if @customer.id && @user.id
      true
    else
      false
    end
  end
end
