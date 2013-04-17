StoreEngine::Application.routes.draw do
  root to: 'stores#index'
  get "/stores" => redirect('/')

  # get "/user" => "users#show"
  get "/code" => redirect("http://github.com/gschorkopf/sonofstore_engine")
  get "/logout" => "sessions#destroy", :as => "logout"
  get "/login" => "sessions#new", :as => "login"
  get "/signup" => "users#signup", :as => "signup"
  post "/buy_now" => "orders#buy_now", :as => 'buy_now'
  put "/i18n" => "i18n#update"
  get "/profile" => "users#show"
  get "/account" => redirect("/profile")
  get "/guest-checkout" => "customers#new", :as => "guest_checkout"
  get "/confirmation-page/:id" => "orders#confirm", :as => "order_confirmation"
  get "/order_details/:uuid_hash" => "orders#display", :as => "obscure_link"

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

    namespace :stock do
      resources :products, except: [:destroy] do
        member do
          post :toggle_status
        end
      end
    end

    namespace :admin do
      get '/' => "stores#show"
      resources :users
      get '/edit' => "stores#edit"
      put '/' => "stores#update"
      resources :stockers
      resources :categories
      resources :products do
        member do
          post :toggle_status
        end
      end
    end
  end

  resources :users

  resources :customers, only: [ :new, :create, :update, :show ] do
    resources :orders
    resource :shipping_addresses, except: [ :index ]
    resource :billing_addresses, except: [ :index ]
    resource :credit_cards, except: [ :index ]
    resource :user, only: [:new, :create, :update, :show]
  end

  namespace :admin do
    # namespace dedicated to platform admin

    root to: redirect("/admin/dashboard")
    get :dashboard, to: "orders#index", as: 'dashboard'

    resources :categories, except: [ :index, :show ]

    resources :orders, only: [ :show, :update ]

    resources :order_items, only: [ :update, :destroy]

    resources :stores, except: [:update, :new] do
      member do
        put :choose_approval_status, :as => "choose_approval_status_on"
        put :toggle_active
      end
    end
  end
end
