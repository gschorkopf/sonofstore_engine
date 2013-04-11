StoreEngine::Application.routes.draw do
  root to: 'stores#index'
  #change this!

  get "/code" => redirect("http://github.com/gschorkopf/sonofstore_engine")
  get "/logout" => "sessions#destroy", :as => "logout"
  get "/login" => "sessions#new", :as => "login"
  get "/signup" => "users#new", :as => "signup"

  get "/account" => redirect("/profile")
  get "/profile" => "users#show"
  # user#show should direct to /profile
  # get "/account/orders" => "orders#index"
  # THIS COULD BE JUST PROFILE/ORDERS. LETS REVISIT

  # get "/account/orders/:id" => "orders#show", :as => "account_order"










  post "/buy_now" => "orders#buy_now", :as => 'buy_now'
  put "/i18n" => "i18n#update"

  resources :sessions, only: [ :new, :create, :destroy ]
  resources :products, only: [ :index, :show ]

  resource :cart, only: [ :update, :show, :destroy ] do
    member do
      put :remove_item
    end
  end

  resources :users, only: [ :new, :create, :update ] do
    resources :orders, except: [ :show ]
  end

  namespace :admin do
  # KEEP IN MIND "ADMIN" IN THIS CONTEXT MEANS PLATFORM ADMIN
    root to: redirect("/admin/dashboard")
    get :dashboard, to: "orders#index", as: 'dashboard'
    get :search, to: "orders#index", as: 'search'

    resources :products do
      member do
        post :toggle_status
      end
    end

    resources :stores, except: [:new] do
      member do
        put :choose_approval_status, :as => "choose_approval_status_on"
        put :toggle_active
      end
    end 
    resources :orders, only: [ :show, :update ]
    resources :order_items, only: [ :update, :destroy]
    resources :categories, except: [ :index, :show ]
  end


  resources :stores, except: [ :index ]

  scope "/:store_path", as: 'store' do
    get '/' => "products#index", as: 'home'
    resources :products, only: [ :show ]
    resources :categories, only: [ :index, :show ]
  end
end
