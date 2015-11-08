Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "callbacks", :registrations => "registrations", sessions: "sessions"}
  resources :ratings, only: [:new, :create]
  resources :referrals, only: [:create, :show]
  resources :events, only: [:index, :create]
  root 'ratings#new'
end
