Rails.application.routes.draw do
  namespace :admin do
    resources :pay_programs
  end

  root 'overview#index'

  get 'overview' => 'overview#index', as: :overview

  put 'update_title' =>  'media_assets#update_title'

  resources :media_assets, path: 'library' do
    collection do
      get 'library'
      delete 'destroy_multiple'
    end
  end

  resources :template_addons

  resources :loop_assets do
    resources :slide_assets, except: [:index, :destroy] do
      member do
        get 'htmlsrc'
        get 'preview'
      end
    end
    member do
      get 'getdata'
    end
    collection do
      delete 'destroy_multiple'
    end
  end

  resources :campaigns do
    member do
      get 'getdata'
      get 'exception_form'
    end
  end

  resources :players, except: [:new, :create, :destroy] do
    member do
      post 'getdata'
      get 'getfiles'
      post 'sendCommand'
    end
  end

  resources :users

  resources :organizations, only: [:show, :edit, :update]

  get 'signup'  => 'users#new'
  get 'login'     => 'sessions#new'
  post 'login'    => 'sessions#create'
  delete 'logout' => 'sessions#destroy', as: :logout

  #Admin panel
  namespace :admin do
    root to: 'overview#index'
    resources :organizations, only: [:index, :show, :edit, :update, :new, :create, :destroy] do
      collection do
        post 'becomeOrg'
      end
    end
    resources :users, only: [:index, :edit, :update, :show, :new, :create, :destroy]
    resources :hardware_types
    resources :players do
      member do
        post 'resetconnection'
      end
    end
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
