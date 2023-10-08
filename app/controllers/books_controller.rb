class BooksController < ApplicationController
  before_action :correct_user, only: [:edit, :update]

  def show
    @newbook = Book.new
    @book = Book.find(params[:id])
    @user = @book.user
    @book_comment = BookComment.new
    @room = Room.new # ここで@roomを生成
    @entry = Entry.new # ここで@entryを生成
  end

  def index
    # @books = Book.all 元はこの記述
     ##本の投稿一覧ページで、過去一週間でいいねの合計カウントが多い順に投稿を表示
    # 現在の日付の終わりの時刻まで取得
    to = Time.current.at_end_of_day

    #7日前の日付取得 beginning = 始まり
    from = (to - 6.day).at_beginning_of_day

     #Bookにfavoritesを読み込んでソートする。期間はfromからtoまで。
     #.sizeは、特定の期間内に作成されたお気に入りの数を表す。
    @books = Book.includes(:favorited_users).
  sort_by {|x|
   x.favorited_users.includes(:favorites).where(created_at: from...to).size
  }.reverse
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body, :user_id)
  end

  def correct_user
    @book = Book.find(params[:id])
    @user = @book.user
    redirect_to(books_path) unless @user == current_user
  end

end
