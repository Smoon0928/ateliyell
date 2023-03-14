class Public::FriendsController < ApplicationController
  def create
    current_user.follow(params[:user_id])
    redirect_to request.referer
  end
  
  def destroy
    current_user.unfollow(params[:user_id])
    redirect_to request.referer
  end
  
  def followings
    @user = User.find(params[:id])
    @users = @user.followings
    
  end

  def followers
    user = User.find(params[:id])
    @users = user.followers
  end
  
  def show
    user = User.find(params[:id])
    @users = user.followers
  end 
  
end