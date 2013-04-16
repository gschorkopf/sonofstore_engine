class Admin::StoresController < ApplicationController
  before_filter :require_platform_admin, except: [:update, :show, :edit]
  before_filter :require_admin, only: [:edit]
  before_filter :require_stocker, only: [:show]

  def index
    @pending_stores = Store.order('name ASC').where(approval_status: 'pending')
    @approved_stores = Store.order('name ASC').where(approval_status: 'approved')
  end

  def show
    @store = Store.find_by_path(params[:store_path])
    @store_users = @store.users
  end

  def edit
    @store = Store.find_by_path(params[:store_path])
  end

  def update
    @store = Store.find_by_path(params[:store_path])

    if @store.update_attributes(params[:store])
      redirect_to store_admin_path(@store),
        :notice  => "Successfully updated store."
    else
      redirect_to store_admin_path(@store),
        :alert  => "Store didn't update. Something went wrong."
    end
  end

  def choose_approval_status
    store = Store.find_by_id(params[:id])
    store.approval_status = params[:status]
    store.active = true if store.approved?
    store.save

    Mailer.store_decision_confirmation(store).deliver
    # Resque.enqueue(StoreDecisionMailer, store.id)

    redirect_to admin_stores_path,
      :notice => "#{store.name} has been #{store.approval_status}"
  end

  def toggle_active
    @store = Store.find(params[:id])
    if @store.toggle_active
      redirect_to admin_stores_path,
        :notice  => "#{@store.name} successfully set to '#{@store.active_to_s}'."
    else
      head 400
    end
  end

  def destroy
    @store = Store.find(params[:id])
    @store.destroy
    redirect_to admin_stores_path, :notice => 'Store successfully deleted'
  end
end
