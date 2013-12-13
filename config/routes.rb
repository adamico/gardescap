Gardescap::Application.routes.draw do
  devise_for :users

  delete "empty_activity", to: "activities#empty"
  get "choix", to: "periods#show"
  get "tableau_actuel", to: "periods#show"
  resources :periods, path: "/tableaux" do
    get :populate, on: :member
  end
  get "tags", to: "gardes#tags", as: "gardes_tags"
  resources :gardes
  resources :activities
  root to: "home#index"
end
