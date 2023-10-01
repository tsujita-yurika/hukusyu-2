class Favorite < ApplicationRecord

  belongs_to :user
  # Favoriteはuserに属している
  belongs_to :book
  # Favoriteはbookに属している

  #belongs_toメソッドを定義することで,
  #userの情報とbookの情報がFavorite(現在のモデル)を経由して取得できるようになる。

end
