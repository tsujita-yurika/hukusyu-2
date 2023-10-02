class RelationshipsController < ApplicationController

    # フォローするとき
  def create
    current_user.follow(params[:user_id])
    redirect_to request.referer
  end
  # フォロー外すとき
  def destroy
    current_user.unfollow(params[:user_id])
    redirect_to request.referer
  end

  def follows
   user = User.find(params[:id])
   @users = user.following_users
  end

  def followers
   user = User.find(params[:id])
   @user = user.follower_users
  end

end