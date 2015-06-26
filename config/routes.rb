Rails.application.routes.draw do
  devise_for :users, skip: [:registration], controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
  devise_scope :user do
    post "users",   to: "users/registrations#create", as: :user_registration
    get "sign_up",  to: "users/registrations#new",    as: :new_user_registration
    get "sign_in",  to: "devise/sessions#new",     as: :new_user_session
    get "sign_out", to: "devise/sessions#destroy", as: :destroy_user_session
  end
  root "presentations#index"

  namespace :manage do
    resources :presentations, only: [:index, :create, :edit, :update]
  end
  get "presentations/search"
  scope "/:username" do
    get "/" => "users#show", as: :user
    get "/:id" => "presentations#show", as: :presentation
  end

  require "sidekiq/web"
  mount Sidekiq::Web => "/sidekiq"
end
