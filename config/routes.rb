Tqm::Application.routes.draw do    

  resources :replies

  resources :schools

  get "welcome/index"
  get "welcome/new"
  post "welcome/create"
  get "welcome/destroy"
  root to: "welcome#index"
  get "welcome/help"
  get "person/:id"=>'welcome#person', as: :person
  post "welcome/person_update"

  # root to: "sessions#new"
  post "/auth/:provider/callback", :to => 'sessions#create'
  get "/auth/failure", to: "sessions#failure"

  

  resources :exams do
    get 'start', on: :member
    get 'order_on_off', on: :member
    get 'set_upload_started', on: :member
    resources :orders
    resources :order_items do
      put 'cancel', on: :member
      put 'confirm',on: :member
      get 'gather',on: :collection
    end
    resources :score_files do
      put 'confirm',on: :member
      put 'cancel',on: :member
      get 'export',on: :collection
      get 'by_school',on: :collection
    end
    resources :reports do
      get 'show_by_school',on: :collection
      put 'confirm',on: :member
      put 'cancel',on: :member
    end
    resources :topics
  end
  
  # get "/exams/:exam_id/school/:school_id/score_files"=>'score_files#by_school',as: :exam_school_files

  resources :qxes
  resources :users


  # faye_server '/faye', :timeout => 25
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
