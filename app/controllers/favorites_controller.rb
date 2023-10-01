class FavoritesController < ApplicationController

  def create
    book = Book.find(params[:book_id])
    favorite= current_user.favorites.new(book_id: book.id)
    #favorites = その時ログインしているユーザーの空のリストを作成
    favorite.save
    #いいねを保存
    redirect_to books_path
  end

  def destroy
    book = Book.find(params[:book_id])
    favorite = current_user.favorites.find_by(book_id: book.id)
    #テーブルから呼ばれたbook.idを見つけてきてdestroyする
    favorite.destroy
    redirect_to books_path
  end

end
