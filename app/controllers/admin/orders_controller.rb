class Admin::OrdersController < ApplicationController
  before_filter :require_admin

  def index
    @count = Order.count
    @orders = Order.find_all_by_store_id(current_store.id)
    @statuses = Order.count(group: :status)
    @active_tab = params[:status] || 'all'
  end

  def show
    @order = Order.find(params[:id])
  end

  def update
    @store = current_store
    @order = Order.find(params[:id])
    if params[:update_status]
      @order.update_status
    end
    redirect_to(:back)
  end
end
