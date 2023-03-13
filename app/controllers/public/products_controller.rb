class Public::ProductsController < ApplicationController
  def index
    @products = Product.all
    @genres = Genre.all 
    
    if params[:genre_id].present?
       @genre = Genre.find(params[:genre_id])
       @products = @genre.products
    end
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to '/products'
    else
      render :new
    end
  end

  #def update
    #product = Product.find(params[:id])
    #product.update(product_params)
    #redirect_to product_path(product.id)
  #end
  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      redirect_to product_path(@product.id)
    else
      render :new
    end
  end

  def show
    @product = Product.find(params[:id])
    @products = Product.all
    @user = User.find(@product.user.id)
    @comment = Comment.new
    @genres = Genre.all
    
    
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
    params.require(:product).permit(:name, :introduction, :genre_id, :user_id, :profile_image, images: [])
  end
  
end
