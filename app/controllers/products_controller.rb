class ProductsController < ApplicationController

  def index
    if params[:format]
      # @products = Product.localness
      @products = Product.three_most_recent
      # @products = Product.most_reviews
    else
      @products = Product.all
      render :index
    end
  end



  def new
    @product = Product.new
    render :new
  end


  def create
    @product = Product.new(product_params)
    if @product.save
      flash[:notice] = "Product successfully added!"
      redirect_to products_path
    else
      render :new
    end
  end

  def edit
    @product = Product.find(params[:id])
    flash[:notice] = "Product edited!"
    render :edit
  end

  def show
    @product = Product.find(params[:id])
    render :show
  end

  def update
    @product= Product.find(params[:id])
    if @product.update(product_params)
      redirect_to products_path
    else
      render :edit
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    flash[:notice] = "Product deleted!"
    redirect_to products_path
  end

  private
  def product_params
    params.require(:product).permit(:name, :cost, :country_of_origin)
  end
end
