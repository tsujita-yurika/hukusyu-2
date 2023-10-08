class Book < ApplicationRecord

  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  #いいねはbookに依存してるからbookが消えたらいいねも消えるようにする

  #閲覧数
  has_many :looks, dependent: :destroy

  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user

    def favorited_by?(user)
    #現在ログインしているユーザーによっていいねされてる？
    favorites.exists?(user_id: user.id)
    #いいねは存在してる？(いいねを既に押してるか、押していないか)
    end
    #引数で渡されたuserがいいねしていれば→true
    #引数で渡されたuserがいいねしていなければ→falseが返される。

    # 検索方法分岐
    def self.looks(search, word)
      if search == "perfect_match"
        @book = Book.where("title LIKE?","#{word}")
      elsif search == "forward_match"
        @book = Book.where("title LIKE?","#{word}%")
      elsif search == "backward_match"
        @book = Book.where("title LIKE?","%#{word}")
      elsif search == "partial_match"
        @book = Book.where("title LIKE?","%#{word}%")
      else
        @book = Book.all
      end
    end

    # userを引数にし、user_idにこのユーザーのidが存在するかを確認する
    def user_has_look?(user)
      looks.where(user_id: user.id).exists?
    end


#完全一致→perfect_match
#前方一致→forward_match
#後方一致→backword_match
#部分一致→partial_match

  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}
end
