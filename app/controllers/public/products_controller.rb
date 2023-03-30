class Public::ProductsController < ApplicationController
  before_action :authenticate_user_admin!, except: [:top]
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  
  def index
    @products = Product.status_public.page(params[:page])
    @genres = Genre.all 
    
    if params[:genre_id].present? && params[:sort_type].present?
      @genre = Genre.find(params[:genre_id])
      if params[:sort_type] == "latest"
        @products = @genre.products.status_public.latest.page(params[:page])
      elsif params[:sort_type] == "old"  
        @products = @genre.products.status_public.old.page(params[:page])
      elsif params[:sort_type] == "like_count" 
        @products = []
        @products_array = Product.find(Like.group(:product_id).order('count(product_id) desc').pluck(:product_id))
        @products_array.each do |product|
          if product.genre_id == @genre.id
            @products << product
          end
        end
        @products = Kaminari.paginate_array(@products).page(params[:page])
      end
    else
      if params[:genre_id].present?
         @genre = Genre.find(params[:genre_id])
         @products = @genre.products.status_public.page(params[:page])
      elsif params[:sort_type] == "latest"
         @products = Product.status_public.latest.page(params[:page])
      elsif params[:sort_type] == "old"
         @products = Product.status_public.old.page(params[:page])
      elsif params[:sort_type] == "like_count"
      #   @products = Product.status_public.like_count.page(params[:page])
         @products = Kaminari.paginate_array(Product.find(Like.group(:product_id).order('count(product_id) desc').pluck(:product_id))).page(params[:page])
      else
         @products = Product.status_public.page(params[:page])
      end
    end
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    
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
    if @product.update(update_product_params)
      flash[:notice] = "作品情報を更新しました"
      redirect_to product_path(@product.id)
    else
      render :edit
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
    
    if product.destroy
    redirect_to '/products'
    flash[:notice] = "作品を削除しました"
    end
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
  
   def update_product_params
    params.require(:product).permit(:name, :introduction, :genre_id, :user_id, :profile_image,:status, images: [])
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
