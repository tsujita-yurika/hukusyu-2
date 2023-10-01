class BookComment < ApplicationRecord

    belongs_to :user
    belongs_to :book
    #BookCommentモデルがUserモデルとBookモデルに対して
    #それぞれ1対多の関連付けを持つ.

    validates :comment, presence: true
    #空のコメントが保存されないようにする。

end
