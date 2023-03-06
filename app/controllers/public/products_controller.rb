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
  end

  def show
    @product=Product.find(params[:id])
  end

  def edit
  end
  
  private
  def product_params
    params.require(:product).permit(:name, :introduction, :image)
  end
  
end
