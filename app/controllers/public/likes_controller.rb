class Public::LikesController < ApplicationController
  before_action :authenticate_user_admin!, except: [:top]
  before_action :authenticate_user!, only: [:create, :destroy, :show]
  
  def create
      @product = Product.find(params[:product_id])
      product = Product.find(params[:product_id])
      like = current_user.likes.new(product_id: product.id)
      like.save
      #redirect_to product_path(product)
  end
  
  def destroy
      @product = Product.find(params[:product_id])
      product =Product.find(params[:product_id])
      like = current_user.likes.find_by(product_id: product.id)
      like.destroy
      #redirect_to product_path(product)
  end
  
  
  
  def like_params
    params.require(:like).permit(:genre_id, :user_id ,:user_name , :product, :profile_image, images:[])
  end
  
end
