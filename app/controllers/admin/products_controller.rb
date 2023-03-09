class Admin::ProductsController < ApplicationController
  def index
    @products=Product.all
  end
  
  def show
  end
  
  def edit
  end
  
  def update
  end
  
   private
  
  def admin_product_params
    params.require(:product).permit(:name, :introduction, :image, :genre_id, :genre_name, :user_name)
  end
  
end
