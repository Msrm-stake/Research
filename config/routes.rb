Rails.application.routes.draw do
  get 'events/index'
  get 'events/show'
  get 'events/new'
  get 'events/create'
  get 'events/edit'
  get 'events/update'
  get 'events/destroy'
  get 'events/attend'
  get 'events/attendees'
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

  resources :events

  
  resources :communities do
    resources :events
  end

  resources :events do
    member do
      post :attend
      delete :leave
    end
  end

  resources :events do
    resources :event_attendees, only: [:index, :create, :destroy] do
      post 'invite', on: :member # This creates the route for inviting a specific attendee
    end
  end

  resources :events do
    resources :event_attendees, only: [:index] # This will create the route for viewing attendees
  end
  
end
