class Public::UsersController < ApplicationController
  before_action :set_user, only: [:followings, :followers]
  before_action :authenticate_user_admin!, except: [:top]
  
  def index
    @users = User.all
  end
    
  def show
    @user = User.find(params[:id])
    @products = @user.products.where(status: 0).page(params[:page]).per(12)
    @private_products = @user.products.where(status: 1)
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def unsubscribe
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
       flash[:notice] = "プロフィール情報の更新が成功しました"
        redirect_to user_path(@user)
    else
      flash[:notice] = "プロフィール情報の更新に失敗しました"
        render :edit
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    if @user.destroy
       flash[:notice] = 'ユーザーを削除しました。'
       redirect_to :root
    end
  end

  def followings
    @users = @user.followings
  end
  
  def followers
    @users = @user.followers
  end
  
  def likes
     @genres = Genre.all
     @user = User.find(params[:id])
    product_ids= Like.where(user_id: @user.id).pluck(:product_id)
    @like_products = Product.where(id: product_ids).page(params[:page]).per(8)
    #@like_array = Kaminari.paginate_array(@like_products).page(params[:page]).per(10)
  end
  

private
  def set_user
    @user = User.find(params[:id])
  end
   
  def user_params
    params.require(:user).permit(:name, :self_introduction, :genre_id, :user_id ,:user_name , :product, :profile_image, images:[])
  end
  
end
