Rails.application.routes.draw do

  devise_for :users, :skip => [:sessions, :passwords, :registrations], 
          :controllers => { omniauth_callbacks: 'omniauth_callbacks' }

  as :user do
    delete 'logout' => 'devise/sessions#destroy', 
                          :as => :destroy_user_session
  end

  get 'login' => 'main#index'
  resources :messages, only: [:index, :create, :edit, :update]
  resources :comments, only: [:new, :create, :edit, :update]
  # get '/comments/new/:id' => 'comments#new', as: :new_comment
  root 'main#index'
  get "*path", :to => redirect('/login')

  match '*any' => 'application#options', :via => [:options]
end