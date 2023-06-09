class Admin::ProductsController < ApplicationController
  before_action :set_product, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  before_action :is_admin?

  def index
    @products = Product.ordered
  end

  def show
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      respond_to do |format|
        format.html { redirect_to admin_products_path, notice: "Product was successfully created." }
        format.turbo_stream { flash.now[:notice] = "Product was successfully created." }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @product.update(product_params)
    respond_to do |format|
      format.html { redirect_to admin_products_path, notice: "Article was successfully updated." }
      format.turbo_stream { flash.now[:notice] = "Product was successfully updated." }
    end
  else
    render :edit, status: :unprocessable_entity
  end
end

  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to admin_products_path, notice: "Product was successfully destroyed." }
      format.turbo_stream { flash.now[:notice] = "Product was successfully destroyed." }
    end
  end
  
  #######
  private
  #######

  def set_product
      @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :description, :price)
  end

  def is_admin?
      if current_user.admin? != true
        redirect_to root_path, notice: "Must be Admin."
      end
  end

end