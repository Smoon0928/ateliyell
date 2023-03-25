class Public::FriendsController < ApplicationController
  before_action :authenticate_user_admin!, except: [:top]
  def create
    current_user.follow(params[:user_id])
    @user = User.find(params[:user_id])
    #redirect_to request.referer
  end
  
  def destroy
    current_user.unfollow(params[:user_id])
    @user = User.find(params[:user_id])
    #redirect_to request.referer
  end
  
  def followings
    user = User.find(params[:id])
    @users = user.followings.page(params[:page])
  end

  def followers
    user = User.find(params[:id])
    @users = user.followers.page(params[:page])
  end
  
  def show
    user = User.find(params[:id])
    @users = user.followers
    @user = User.find(params[:id])
  end 
  
end