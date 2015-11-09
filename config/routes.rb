Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "callbacks", :registrations => "registrations", sessions: "sessions"}
  resources :ratings, only: [:new, :create]
  resources :referrals, only: [:create, :show]
  resources :events, only: [:index, :create]
  get 'events/admin', to: 'events#admin'

  devise_scope :user do
    get 'users/show/:id', to: 'registrations#show'
  end
  
  root 'ratings#new'
end
