class OrdersController < ApplicationController
  # before_filter :require_login

  def new
    if current_user
      @customer = current_user.customer
    else
      @customer = Customer.find_by_id(params[:customer_id])
    end
    @cart_items = session[(params[:store_path])]
  end

  def display
    @order = Order.find_by_uuid_hash(params[:uuid_hash])
  end

  def index
    @orders = Order.find_all_by_customer_id(params[:customer_id])
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
    @order = Order.new
    uuid = UUID.new.generate
    # @order = Order.create(status: 'pending', customer_id: @customer_id)
    @order.uuid_hash = uuid
    @order.customer_id = @customer_id
    @order.store_id = current_store.id
    @order.status = "pending"
    @order.save

    session[current_store.path].each do |product_id, quantity|
      product = Product.find(product_id)
      @order.order_items.create(product_id: product.id,
                               unit_price: product.price,
                               quantity: quantity)
    end

    if @order.save
      Mailer.order_confirmation(@customer_id, @order).deliver
      # Resque.enqueue(OrderMailer, current_user.id, @order.id)
      session[current_store.path] = {}

      if current_user
        redirect_to customer_order_path(@customer_id, @order.id), :notice => "Successfully created order!"
      else
        redirect_to order_confirmation_path(@order.id),
        :notice => "Successfully created order!"
      end
    else
      redirect_to store_cart_path(current_store), :notice => "Checkout failed."
    end
  end
end
