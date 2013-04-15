class OrdersController < ApplicationController
  # before_filter :require_login

  def new
    if current_user
      @customer = current_user.customer
    else
      @customer = Customer.find_by_id(params[:customer_id])
    end
    @cart = current_cart
  end

  def display
    @order = Order.find_by_uuid_hash(params[:uuid_hash])
  end

  def index
    @orders = Order.find_all_by_customer_id(current_user.customer_id)
  end

  def show
    order = Order.find(params[:id])
    if current_user.customer_id == order.customer_id
      @order = Order.find(params[:id])
    else
      redirect_to customer_orders_path
    end
  end

  def confirm
    @order = Order.find_by_id(params[:id])
  end

  def create
    @customer_id = params[:customer_id]
    uuid = UUID.new.generate
    @order = Order.create(status: 'pending', customer_id: @customer_id)
    @order.uuid_hash = uuid

    session[:cart].each do |product_id, quantity|
      product = Product.find(product_id)
      @order.order_items.create(product_id: product.id,
                               unit_price: product.price,
                               quantity: quantity)
    end

    if @order.save
      Mailer.order_confirmation(@customer_id, @order).deliver
      # Resque.enqueue(OrderMailer, current_user.id, @order.id)
      session[:cart] = {}
      Resque.enqueue(OrderMailer, @customer_id, @order.id)
      if current_user
        redirect_to customer_orders_path(@order), :notice => "Successfully created order!"
      else
        redirect_to order_confirmation_path(@order.id), :notice => "Successfully created order!"
      end
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
