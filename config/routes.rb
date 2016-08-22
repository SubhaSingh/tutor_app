Rails.application.routes.draw do

  get 'calendars/show'

  root 			                'static_pages#home' 	 #Default home page (home action in static pages controller)
  get     'about'     =>		'static_pages#about'	 #Route to about page
  get     'contact'   =>    'static_pages#contact' #Route to contact page
  get     'signup'    =>    'users#new'            #Route to signup page for new users
  get     'login'     =>    'sessions#new'         #login page
  post    'login'     =>    'sessions#create'      #create new session
  delete  'logout'    =>    'sessions#destroy'     #destroy session
  get     'dashboard' =>    'dashboard#show'       #Route to dashboard
  get     'home'      =>    'courses#show'         #Route to courses home page

  resources :users                                    #All REST actions for resource users
  resources :account_activations, only: [:edit]       #Route for account activation edit action to change user active status
  resources :password_resets,     only: [:edit, :new, :create, :update] #Routes for password reset actions
  resources :calendars,           only: [:show]
  resources :contacts,            only: [:new, :create]
  resources :feedbacks,           only: [:new, :create]

  #Nested resources
  resources :courses do
    resources :password_resets       
    resources :tutor_informations
    resources :posts
    resources :meetings do
      resources :meeting_members
    end
    resources :assessments do
      resources :assessment_tutors
      
      resources :students do
        collection do
         match :import, :via => [:post]
         match :remove_all, :via => [:post, :get]
        end
      end
    end
    resources :members do
      collection do
        match :tutor, :via => [:post, :get]
        match :lecturer, :via => [:post, :get]
        match :delete_tutor, :via => [:post, :get]
        match :delete_lecturer, :via => [:post, :get]
      end
    end
    resources :invites
    resources :solutions
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
