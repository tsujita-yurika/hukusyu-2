class Book < ApplicationRecord

  belongs_to :user
  has_many :favorites, dependent: :destroy
  #いいねはbookに依存してるからbookが消えたらいいねも消えるようにする

    def favorited_by?(user)
    #現在ログインしているユーザーによっていいねされてる？
    favorites.exists?(user_id: user.id)
    #いいねは存在してる？(いいねを既に押してるか、押していないか)
    end
    #引数で渡されたuserがいいねしていれば→true
    #引数で渡されたuserがいいねしていなければ→falseが返される。
    

  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}
end
