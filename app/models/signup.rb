class Signup
  attr_reader :customer, :user

  def initialize(params)
    @customer = Customer.find_or_create_by_email(params[:email])
    @customer.full_name = params[:full_name]
    @customer.save

    @user = User.create(display_name: params[:display_name],
                            password: params[:password],
               password_confirmation: params[:password_confirmation],
                         customer_id: @customer.id)
  end

  def success?
    if @customer.id && @user.id
      true
    else
      false
    end
  end
end
