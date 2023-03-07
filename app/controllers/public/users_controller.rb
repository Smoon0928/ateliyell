class Public::UsersController < ApplicationController
  def show
    @user=User.find(params[:id])
    @product_images=@user.profile_image
  end

  def edit
    @user=User.find(params[:id])
  end

  def update
    if @user.update(user_params)
      render_to user_path(@user), notice: "プロフィール情報の更新が成功しました"
    else
      render "edit"
    end
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
