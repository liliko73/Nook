Rails.application.routes.draw do
  get "themes/show"
  devise_for :users, controllers: {
    registrations: "users/registrations"
  }

  # Deviseのregistrationsコントローラーに独自アクションを追加
  devise_scope :user do
    post "users/sign_up/confirm", to: "users/registrations#new_confirm"
    get  "users/sign_up/complete", to: "users/registrations#new_complete", as: :users_sign_up_complete
  end

  root "static_pages#top"

  # テーマ詳細表示用
  resources :themes, only: [ :index, :show ] do
    resources :comments, only: [ :create ]
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
end
