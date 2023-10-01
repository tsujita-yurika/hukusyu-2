class CreateFavorites < ActiveRecord::Migration[6.1]
  def change
    create_table :favorites do |t|

      t.integer :user_id
      #user_id	integer	「いいね」したユーザのID
      t.integer :book_id
      #book_id	integer	「いいね」された投稿のID
      t.timestamps
    end
  end
end
