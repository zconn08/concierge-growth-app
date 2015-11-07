Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "callbacks" }
  resources :ratings
  resources :referrals, only: [:create, :show] 
  root 'ratings#new'
end
