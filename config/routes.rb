Rails.application.routes.draw do
  devise_for :users, skip: [:registration], controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
  devise_scope :user do
    post "users",   to: "users/registrations#create", as: :user_registration
    get "sign_up",  to: "users/registrations#new",    as: :new_user_registration
    get "sign_in",  to: "devise/sessions#new",     as: :new_user_session
    get "sign_out", to: "devise/sessions#destroy", as: :destroy_user_session
  end
  root "presentations#index"

  resources :presentations, only: [:create]
  get "presentations/search"
  scope "/:username" do
    resources :presentations, only: [:index, :show], as: :public_presentation
  end

  require "sidekiq/web"
  mount Sidekiq::Web => "/sidekiq"
end
