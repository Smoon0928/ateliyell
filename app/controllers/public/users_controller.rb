class Public::UsersController < ApplicationController
  before_action :set_user, only: [:followings, :followers]
  
  def index
  end
  
  
  def show
    @user = User.find(params[:id])
    # @profile_image = @user.profile_image
    @products = @user.products.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
       flash[:success] = "プロフィール情報の更新が成功しました"
        redirect_to user_path(@user)
    else
      flash[:danger] = "プロフィール情報の更新に失敗しました"
        render :edit
    end
  end
    

  def unsubscribe
  end

  def withdraw
  end
  
  def followings
    @users = @user.followings
  end
  
  def followers
    @users = @user.followers
  end
  

private
  def set_user
    @user = User.find(params[:id])
  end
   
  def user_params
    params.require(:user).permit(:name, :self_introduction, :genre_id, :user_id ,:user_name , :product, :profile_image, images:[])
  end
  
end
