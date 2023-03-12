class Admin::UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @product = Product.find(params[:id])
    @user = User.find(@product.user.id)

  end

  def edit
  end
  
  private
    def customer_params
      params.require(:user).permit(:user_name, :email, :is_deleted, :product)
    end
end
