class OrdersController < ApplicationController
  before_filter :require_login

  def new
    @user = current_user
    @cart = current_cart
  end

  def index
    @orders = Order.find_all_by_user_id(current_user)
  end

  def show
    order = Order.find(params[:id])
    if current_user.id == order.user_id
      @order = Order.find(params[:id])
    else
      redirect_to account_orders_path
    end
  end

  def create
    @order = Order.create(status: 'pending', user_id: current_user.id)

    session[:cart].each do |product_id, quantity|
      product = Product.find(product_id)
      @order.order_items.create(product_id: product.id,
                               unit_price: product.price,
                               quantity: quantity)
    end

    if @order.save
      Mailer.order_confirmation(current_user, @order).deliver
      # Resque.enqueue(OrderMailer, current_user.id, @order.id)
      session[:cart] = {}
      redirect_to user_orders_path(@order), :notice => "Successfully created order!"
    else
      redirect_to cart_path, :notice => "Checkout failed."
    end
  end



  def buy_now
    @order = Order.create_and_charge(cart: Cart.new({params[:order] => '1'}),
                                     user: current_user)
    if @order.save
      session[:cart] = current_cart.destroy
      Mailer.order_confirmation(current_user, @order).deliver
      # Resque.enqueue(OrderMailer, current_user.id, @order.id)
      redirect_to account_order_path(@order),
        :notice => "Order submitted!"
    else
      redirect_to :back, :notice => "Checkout failed."
    end
  end
end
