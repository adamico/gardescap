Gardescap::Application.routes.draw do
  devise_for :users

  get "gardes/prochain_choix", to: "periods#show"
  get "tags", to: "gardes#tags", as: "gardes_tags"
  resources :gardes
  root to: "home#index"
end
