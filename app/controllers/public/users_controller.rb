class Public::UsersController < ApplicationController
  def show
    @user=User.find(params[:id])
    @product_images=@user.product_images
  end

  def edit
  end

  def update
  end

  def unsubscribe
  end

  def withdraw
  end
  
   private
  def product_params
    params.require(:user).permit(:name, :introduction, :genre_id, :user_id ,:user_name , :product, images:[])
  end
  
end
