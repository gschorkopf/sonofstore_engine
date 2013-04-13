class StoresController < ApplicationController
  
  def index
    @stores = Store.order('name ASC').where(approval_status: 'approved')
  end

  def show
    @store = Store.find(params[:id])
  end

  def new
    @store = Store.new
  end

  def edit
    @store = Store.find(params[:id])
  end

  def create
    @store = Store.new(params[:store])

    if @store.save
      ur = UserRole.create(user_id: current_user.id,
                      store_id: @store.id )
      ur.role = 'store_admin'
      ur.save

      Resque.enqueue(StoreCreateMailer, current_user.id, @store.id)
      
      redirect_to profile_path, notice: "Thanks for your submission! #{@store} is currently pending."
    else
      render action: "new"
    end
  end

  def update
    @store = Store.find(params[:id])
    if @store.update_attributes(params[:store])
      redirect_to @store, notice: 'Store was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @store = Store.find(params[:id])
    @store.destroy
    redirect_to admin_stores_path, :notice => 'Store successfully deleted'
  end
end
