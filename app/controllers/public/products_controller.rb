class Public::ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  
  def index
    @products = Product.status_public.page(params[:page])
    @genres = Genre.all 
    
    if params[:genre_id].present?
       @genre = Genre.find(params[:genre_id])
       @products = @genre.products.status_public.page(params[:page])
    elsif params[:latest].present?
       @products = Product.status_public.latest.page(params[:page])
    elsif params[:old].present?
       @products = Product.status_public.old.page(params[:page])
    elsif params[:like_count].present?
       @products = Product.status_public.like_count.page(params[:page])
    else
       @products = Product.status_public.page(params[:page])
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

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      redirect_to product_path(@product.id)
    else
      render :new
    end
  end
  
  def upload_image
      @image_blob = create_blob(params[:image])
      respond_to do |format|
        format.json { @image_blob.id }
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
  
  def private
    @user = User.find(current_user.id)
    @private_products = @user.products.where(status: 1)
  end
  
  private
  
  def set_product
      @product = Product.find(params[:id])
  end
    
  def product_params
    params.require(:product).permit(:name, :introduction, :genre_id, :user_id, :profile_image,:status).merge(images: uploaded_images)
  end
  
  def uploaded_images
    params[:product][:images].map{|id| ActiveStorage::Blob.find(id)} if params[:product][:images]
  end

  def create_blob(uploading_file)
    ActiveStorage::Blob.create_after_upload! \
      io: uploading_file.open,
      filename: uploading_file.original_filename,
      content_type: uploading_file.content_type
  end
  
end
