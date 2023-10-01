Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users
  root to: 'homes#top'
  get "home/about"=>"homes#about"

  resources :books, only: [:index,:show,:edit,:create,:destroy,:update]
  resources :users, only: [:index,:show,:edit,:update]
  resource :favorites, only: [:create, :destroy]
#ルーティングをネストさせる。
#ネストとは、あるコントローラーへのルーティングの記述の中に
#別のコントローラへのルーティングを記述すること。
#URLにparams[:id]を使わなくてもいいためresourceになっている。
#ユーザーIDと投稿IDがわかれば、どのいいねを削除するかを特定できる。
#したがって、いいねのIDをURLに含める必要はない！

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
