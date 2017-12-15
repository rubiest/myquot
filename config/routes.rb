Rails.application.routes.draw do
  namespace :dashboard, path: '/dashboard' do
    get "/" => "dashboard#index"
  end

  namespace :account, path: '/account' do
    resource :profiles, except: [:index, :new, :destroy]
  end

  root 'pages#index'

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    confirmations: 'users/confirmations',
    passwords: 'users/passwords',
    unlocks: 'users/unlocks'
  }

  devise_scope :user do
    get '/login' => 'users/sessions#new'
    get '/register' => 'users/registrations#new'
    get '/settings' => 'users/registrations#edit'
  end
end
