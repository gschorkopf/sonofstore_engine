class OrdersController < ApplicationController

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
      redirect_to customer_orders_path(current_user.customer_id),
      :notice => "You are not authorized to view other customers data!"
    end
  end

  def confirm
    @order = Order.find_by_id(params[:id])
  end

  def create
    @customer_id = params[:customer_id]
    @order = Order.generate_new_order( current_store.id,
                                       @customer_id,
                                       session[current_store.path] )
    if @order.save
      Mailer.order_confirmation(@customer_id, @order).deliver

      session[current_store.path] = {}

      redirect_to order_confirmation_path(@order.id),
      :notice => "Successfully created order!"
    else
      redirect_to store_cart_path(current_store), :notice => "Checkout failed."
    end
  end
end
