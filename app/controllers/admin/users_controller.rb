class Admin::UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])

  end

  def edit
  end
  
  private
    def customer_params
      params.require(:user).permit(:user_name, :email, :is_deleted, :product)
    end
end
