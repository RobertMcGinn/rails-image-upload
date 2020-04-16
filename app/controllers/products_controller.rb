class ProductsController < ApplicationController

  def index
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    # binding.pry
    if @product.save
      flash[:notice] = "Product: '#{@product.name}' was created."
      redirect_to edit_product_path(@product)
    else
      flash.now[:alert] = "Product creation failed."
      render :new
    end
  end

  def show
    # binding.pry
    @product = Product.find_by(id: params[:id])

    if @product
      render :show
    else
      flash[:notice] = 'Product not found'
      redirect_to root_path
    end
  end

  def edit 
    # binding.pry
    @product = Product.find_by(id: params[:id])
  end

  def edit_image
    image_type = params[:image_product][:type]
    id = params[:image_product][:id]

    if image_type && id
      @product =  Product.find_by(id: id)
      render :crop, locals:  { image_type: image_type}
    else
      redirect_to :back
    end
  end

   def update
    # binding.pry
    @product = Product.find(params[:id])
    @product.image_type = params[:image_type]

    if @product.update_attributes(product_params)
      # binding.pry
      flash[:notice] = "Product: '#{@product.name}' was updated."
      redirect_to product_path(@product)
    else
      flash[:notice] = 'failed to update'
      redirect_to :back
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :crop_x, :crop_y, :crop_w, :crop_h, :img_for_update, :avatar, :image2)
  end
end
