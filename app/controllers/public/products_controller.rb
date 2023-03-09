class Public::ProductsController < ApplicationController
  def index
    @products=Product.all
  end

  def new
    @product=Product.new
  end

  def create
    @product=Product.new(product_params)
    if @product.save
      redirect_to '/products'
    else
      render :new
    end
  end

  def update
    product=Product.find(params[:id])
    product.update(product_params)
    redirect_to product_path(product.id)
  end

  def show
    @product=Product.find(params[:id])
    
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
  
  def destroy
    product = Product.find(params[:id])
    product.destroy
    redirect_to '/products'
  end
  
  private
  def product_params
    params.require(:product).permit(:name, :introduction, :genre_id, :user_id, images: [])
  end
  
end
