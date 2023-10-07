class UsersController < ApplicationController
    #[:XXX] } に直打ち禁止したいアクションを追記
   before_action :ensure_correct_user, { only: [:edit, :update, :destroy] }
   before_action :authenticate_user!, only: [:show]

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
    #ユーザー詳細ページで、フォロー数とフォロワー数を表示するための記述
    @following_users = @user.following_users
    @follower_users = @user.follower_users

    #DM
    @currentUserEntry = Entry.where(user_id: current_user.id)
    #現在ログインしているユーザーの全Entryデータを取得
    @userEntry = Entry.where(user_id: @user.id)
    #@userの全Entryデータを取得
    unless @user.id == current_user.id
    #@user と current_user が別人の時
    @currentUserEntry.each do |cu|
    #現在ログインしているユーザーの全Entryデータを1つずつ取り出します。
        @userEntry.each do |u|
    #@userの全Entryデータを1つずつ取り出します。
          if cu.room_id == u.room_id
    #現在ログインしているユーザーのEntryデータのうち、room_idが
    #@userのEntryデータの持つroom_idと同じ時
            @isRoom = true
#現在ログインしているユーザーと@userの共通のRoomがあることを明確にしている
            @roomId = cu.room_id
#@roomIdに その現在ログインしているユーザーと@userの共通のroom_idを代入
          end
        end
    end
      if @isRoom
      else
        @room = Room.new
        @entry = Entry.new
      end
    end

  end

  def index
    @users = User.all
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "You have updated user successfully."
    else
      render "edit"
    end
  end

  # フォロー一覧
  def follows
    user = User.find(params[:id])
    @users = user.following_users
  end

  # フォロワー一覧
  def followers
    user = User.find(params[:id])
    @user = user.follower_users
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end
