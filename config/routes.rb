Rails.application.routes.draw do
  # ログイン前後のトップ画面
  root "static_pages#top"

  # OmniAuthのログイン画面への遷移
  get "/auth/:provider/callback", to: "sessions#create"
  get "/logout", to: "sessions#destroy"

  # 家族グループの設定
  resources :family_groups do
    member do
      post :invite_member
      delete :remove_member
      post :generate_invite
      get :join
    end
  end

  # MVP時点ではアカウントのあるユーザーのみに対応、退会機能未実装。
  # アカウントの無い人用に、newやdestroyが必要になる可能性あり。
  resource :user, only: %i[show edit update]
  resources :medical_histories

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"
end
