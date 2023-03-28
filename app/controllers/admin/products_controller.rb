class Admin::ProductsController < ApplicationController
  before_action :set_product, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  before_action :is_admin?

  def index
    @products = Product.all
  end

  def show
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to admin_products_path, notice: "Product was successfully created."
    else
      render :new
    end
  end

  def edit
  end

  def update
    @product.update(post_params)
    redirect_to admin_products_path, notice: "Product was successfully updated."
  end

  def destroy
    @product.destroy
    redirect_to admin_products_path, notice: "Product was successfully destroyed."
  end
  
  #######
  private
  #######

  def set_product
      @product = Product.find(params[:id])
  end

  def post_params
    params.require(:product).permit(:name, :description, :price)
  end

  def is_admin?
      if current_user.admin? != true
        redirect_to root_path, notice: "Must be Admin."
      end
  end

end