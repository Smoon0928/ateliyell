class Public::ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  
  def index
    @products = Product.all.status_public
    @genres = Genre.all 
    
    if params[:genre_id].present?
       @genre = Genre.find(params[:genre_id])
       @products = @genre.products.status_public
    end
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    # if @product.save
    #   redirect_to '/products'
    # else
    #   render :new
    # end
    
    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: '新規投稿を行いました。' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
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
    
    if @product.status_private? && @product.user != current_user
      respond_to do |format|
        format.html { redirect_to products_path, notice: 'このページにはアクセスできません' }
      end
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
  
  def set_product
      @product = Product.find(params[:id])
    end
    
  def product_params
    params.require(:product).permit(:name, :introduction, :genre_id, :user_id, :profile_image,:status, images: [])
  end
  
end
