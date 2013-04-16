class StoresController < ApplicationController
  def index
    @stores = Store.where(active: true).order('name ASC')
  end

  def new
    @store = Store.new
  end

  def create
    @store = Store.new(params[:store])

    if @store.save
      ur = UserRole.create(user_id: current_user.id,
                      store_id: @store.id )
      ur.role = 'store_admin'
      ur.save

      Mailer.store_creation_confirmation(current_user, @store).deliver
      # Resque.enqueue(StoreCreateMailer, current_user.id, @store.id)

      redirect_to profile_path, notice: "Thanks for your submission! #{@store} is currently pending."
    else
      render action: "new"
    end
  end
end
