Rails.application.routes.draw do
  devise_for :owners
  devise_for :members
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  devise_scope :owner do
    post '/api/v1/owners/sign_in', to: 'api/v1/owners/sessions#create'
    delete '/api/v1/owners/sign_out', to: 'api/v1/owners/sessions#destroy'
  end

  devise_scope :member do
    post '/api/v1/members/sign_in', to: 'api/v1/members/sessions#create'
    delete '/api/v1/members/sign_out', to: 'api/v1/members/sessions#destroy'
  end

  namespace :api do
    namespace :v1 do
      # オーナー
      namespace :owners do
        # CSRF
        get '/csrf', to: 'csrf#index'
        # 認証
        post '/sign_up', to: 'registers#create'
        get '/identity', to: 'members#identity'
        patch '/profile', to: 'members#update'
        # ショップ
        get '/shops', to: 'shops#index'
        get '/shops/:id', to: 'shops#show'
        post '/shops', to: 'shops#create'
        put '/shops/:id', to: 'shops#update'
        delete '/shops/:id', to: 'shops#destroy'
        # 商品
        get '/items', to: 'items#index'
        get '/items/:id', to: 'items#show'
        post '/items', to: 'items#create'
        put '/items/:id', to: 'items#update'
        delete '/items/:id', to: 'items#destroy'
        # お知らせ
        get '/release_info', to: 'release_info#index'
        get '/release_info/:id', to: 'release_info#show'
        post '/release_info', to: 'release_info#create'
        patch '/release_info/:id', to: 'release_info#update'
        delete '/release_info/:id', to: 'release_info#destroy'
        # 購入履歴
        get '/purchases', to: 'purchases#index'
        get '/purchases/:id', to: 'purchases#show'
      end

      # 会員
      namespace :members do
        # CSRF
        get '/csrf', to: 'csrf#index'
        # 認証
        post '/sign_up', to: 'registers#create'
        get '/identity', to: 'members#identity'
        patch '/profile', to: 'members#update'
        # 発送情報
        get '/shipping_info', to: 'shipping_info#index'
        get '/shipping_info/:id', to: 'shipping_info#show'
        post '/shipping_info', to: 'shipping_info#create'
        patch '/shipping_info/:id', to: 'shipping_info#update'
        delete '/shipping_info/:id', to: 'shipping_info#destroy'
        # ショップ
        get '/shops', to: 'shops#index'
        get '/shops/:id', to: 'shops#show'
        # 商品
        get '/items', to: 'items#index'
        get '/items/:id', to: 'items#show'
        # カート
        get '/cart_items', to: 'cart_items#index'
        post '/cart_items', to: 'cart_items#create'
        delete '/cart_items/:id', to: 'cart_items#destroy'
        # 購入
        get '/purchases', to: 'purchases#index'
        post '/purchases', to: 'purchases#create'
        delete '/purchases/:id', to: 'purchases#destroy'
        # レビュー
        get '/reviews', to: 'reviews#index'
        post '/reviews', to: 'reviews#create'
        delete '/reviews/:id', to: 'reviews#destroy'
        # お気に入り
        get '/favorite_items', to: 'favorite_items#index'
        put '/favorite_items/:id', to: 'favorite_items#update'
        # お知らせ
        get '/release_info', to: 'release_info#index'
        get '/release_info/:id', to: 'release_info#show'
      end
    end
  end
end
