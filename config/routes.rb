Rails.application.routes.draw do

  devise_for :users, :skip => [:sessions, :passwords, :registrations], 
          :controllers => { omniauth_callbacks: 'omniauth_callbacks' }

  as :user do
    delete 'logout' => 'devise/sessions#destroy', 
                          :as => :destroy_user_session
  end

  get 'login' => 'main#index'
  get 'messages' => 'messages#index', as: :messages
  root 'main#index'
  get "*path", :to => redirect('/login')

end