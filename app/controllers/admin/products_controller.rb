class Admin::ProductsController < ApplicationController
  def index
    @products = Product.all
  end
  
  def show
    @product = Product.find(params[:id])
    @products = Product.all
    @user = User.find(@product.user.id)
    @comment = Comment.new
    
     @selected_image = if params[:image_index].present?
      index = params[:image_index].to_i
      @product.images[index]
    else
      @product.images.first
    end
  end
  
  def edit
    @product = Product.find(params[:id])
  end
  
  def update
  end
  
   private
  
  def admin_product_params
    params.require(:product).permit(:name, :introduction, :image, :genre_id, :genre_name, :user_name)
  end

end
