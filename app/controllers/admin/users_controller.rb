class Admin::UsersController < ApplicationController
   before_action :authenticate_admin!
  # before_action :ensure_guest_user, only: [:edit]
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @products = @user.products
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:notice] = 'ユーザーを削除しました。'
    redirect_to admin_users_path
  end
  
  def unsubscribe
    @user = User.find(params[:id])
  end
  
  private
    def customer_params
      params.require(:user).permit(:user_name, :email, :is_deleted, :product)
    end
    
    def ensure_guest_user
    @user = User.find(params[:id])
      if @user.name == "guestuser"
        redirect_to user_path(current_user) , notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
      end
    end  
end
