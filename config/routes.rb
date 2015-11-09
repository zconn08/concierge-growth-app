Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "callbacks", :registrations => "registrations", sessions: "sessions"}
  resources :ratings, only: [:index, :new, :create]
  resources :referrals, only: [:create, :show]
  resources :events, only: [:index, :create]
  resources :admin, only: [:index]

  devise_scope :user do
    get 'users/show/:id', to: 'registrations#show'
  end

  root 'ratings#new'
end
