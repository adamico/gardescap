Gardescap::Application.routes.draw do
  devise_for :users

  get "gardes/prochain_choix", to: "periods#show"
  resources :gardes
  root to: "home#index"
end
