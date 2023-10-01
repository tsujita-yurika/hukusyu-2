Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users
  root to: 'homes#top'
  get "home/about"=>"homes#about"

  resources :books, only: [:index,:show,:edit,:create,:destroy,:update] do
    resources :book_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end
  #ルーティングをネスト(親子関係を設定)する。
#ネストとは、あるコントローラーへのルーティングの記述の中に
#別のコントローラへのルーティングを記述すること。
#いいねはURLにparams[:id]を使わなくてもいいためresourceになっている。
#ユーザーIDと投稿IDがわかれば、どのいいねを削除するかを特定できる。
#したがって、いいねのIDをURLに含める必要はない


  resources :users, only: [:index,:show,:edit,:update]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
