StoreEngine::Application.routes.draw do
  root to: 'stores#index'
  get "/stores" => redirect('/')

  get "/code" => redirect("http://github.com/gschorkopf/sonofstore_engine")
  get "/logout" => "sessions#destroy", :as => "logout"
  get "/login" => "sessions#new", :as => "login"
  get "/signup" => "users#new", :as => "signup"
  post "/buy_now" => "orders#buy_now", :as => 'buy_now'
  put "/i18n" => "i18n#update"
  get "/profile" => "users#show"
  get "/account" => redirect("/profile")

  resource :cart, only: [ :update, :show, :destroy ] do
    member do
      put :remove_item
    end
  end

  resources :products, only: [ :index, :show ]

  resources :sessions, only: [ :new, :create, :destroy ]

  resources :stores, except: [ :index ]

  scope "/:store_path", as: 'store' do
    get '/' => "products#index", as: 'home'
    resources :products, only: [ :index, :show ]
    resources :categories, only: [ :index, :show ]
    
    namespace :admin do
      get '/' => "users#show", as: 'home'
      resources :users
      resources :products do
        member do
          post :toggle_status
        end
      end
    end
  end

  resources :users, only: [ :new, :create, :update ] do
    resources :orders, except: [ :show ]
    resource :shipping_addresses, except: [ :index ]
    resource :billing_addresses, except: [ :index ]
    resource :credit_cards, except: [ :index ]
  end

  namespace :admin do
    # namespace dedicated to platform admin
    root to: redirect("/admin/dashboard")
    get :dashboard, to: "orders#index", as: 'dashboard'
    # get :search, to: "orders#index", as: 'search'

    resources :categories, except: [ :index, :show ]

    resources :orders, only: [ :show, :update ]
    
    resources :order_items, only: [ :update, :destroy]

    # resources :products do
    #   member do
    #     post :toggle_status
    #   end
    # end

    resources :stores, except: [:new] do
      member do
        put :choose_approval_status, :as => "choose_approval_status_on"
        put :toggle_active
      end
    end
  end
end
