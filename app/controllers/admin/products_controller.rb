class Admin::ProductsController < ApplicationController
  def index
  end
  
  def show
  end
  
  def edit
  end
  
  def update
  end
  
   private
  
  def admin_item_params
    params.require(:product).permit(:name, :introduction,  :image, :genre_id)
  end
end
