Rails.application.routes.draw do
  get 'event_attendances/create'
  get 'event_attendances/destroy'
  devise_for :users
  root to: "pages#home"
  get '/about_us', to: 'pages#about_us', as: 'about_us'
  resources :communities
  resources :articles
  resources :articles do
    post 'upload_image', on: :collection
  end

  resources :articles do
    resources :comments, only: [:create]
  end
  
  resources :articles do
    resources :comments do
      post 'reply', on: :member
    end
  end

  resources :communities do
    resources :events
  end

  resources :communities do
    resources :events, only: [:index, :show]
  end

  resources :events do
    resources :event_attendances, only: [:create, :destroy]
  end

  resources :events do
    member do
      get :attendees  # This maps to the attendees action in the controller
    end
  end
  
end
