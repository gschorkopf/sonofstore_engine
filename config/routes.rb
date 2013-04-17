StoreEngine::Application.routes.draw do
  root to: 'stores#index'
  get "/stores" => redirect('/')

  get "/code" => redirect("http://github.com/gschorkopf/sonofstore_engine")
  get "/logout" => "sessions#destroy", :as => "logout"
  get "/login" => "sessions#new", :as => "login"
  get "/signup" => "users#signup", :as => "signup"
  get "/profile" => "users#show"
  get "/account" => redirect("/profile")
  get "/guest-checkout" => "customers#new", :as => "guest_checkout"
  get "/confirmation-page/:id" => "orders#confirm", :as => "order_confirmation"
  get "/order_details/:uuid_hash" => "orders#display", :as => "obscure_link"

  namespace :admin do
    root to: redirect("/admin/dashboard")
    get :dashboard, to: "orders#index", as: 'dashboard'

    resources :orders, only: [ :show, :update ]

    resources :order_items, only: [ :update, :destroy ]

    resources :stores, except: [:update, :new ] do
      member do
        put :choose_approval_status, :as => "choose_approval_status_on"
        put :toggle_active
      end
    end
  end

  resource :cart, only: [ :update, :show, :destroy ] do
    member do
      put :remove_item
    end
  end

  resources :customers, only: [ :new, :create, :update ] do
    resources :orders, except: [ :destroy ]
    resource :shipping_addresses, except: [ :index, :show, :destroy ]
    resource :billing_addresses, except: [ :index, :show, :destroy ]
    resource :credit_cards, except: [ :index, :show, :destroy ]
    resource :user, only: [:new, :create, :update, :show ]
  end

  resources :sessions, only: [ :new, :create, :destroy ]

  resources :stores, only: [ :new, :create ]

  scope "/:store_path", as: 'store' do
    get '/' => "products#index", as: 'home'
    resources :products, only: [ :index, :show ]
    resources :categories, only: [ :index, :show ]

    namespace :stock do
      resources :products, except: [ :destroy ] do
        member do
          post :toggle_status
        end
      end
    end

    namespace :admin do
      get '/' => "stores#show"
      get '/edit' => "stores#edit"
      put '/' => "stores#update"
      resources :users, except: [ :index, :update, :edit, :show ]
      resources :stockers
      resources :categories, except: [ :destroy ]
      resources :products do
        member do
          post :toggle_status
        end
      end
    end
  end

  resources :users
  # Why do we have this as a duplicate to :customers => :users ?
end
