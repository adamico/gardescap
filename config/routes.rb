Gardescap::Application.routes.draw do
  devise_for :users

  get "choix", to: "periods#show"
  get "tableau_actuel", to: "periods#show"
  resources :periods, as: :tableaux, path: "/tableaux" do
    get :populate, on: :member
  end
  get "tags", to: "gardes#tags", as: "gardes_tags"
  resources :gardes
  root to: "home#index"
end
