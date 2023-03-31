class ProductsController < ApplicationController
  before_action :authenticate_user!, only: %i[like]

  def index
    @products = Product.ordered
  end

  def show
    @product = Product.find(params[:id])
  end

  def like
    @product = Product.find(params[:id])
    current_user.like(@product)
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: private_stream
      end
    end
  end

  #######
  private
  #######

  def private_stream
    private_target = "#{helpers.dom_id(@product)}_private_likes"
    turbo_stream.replace(private_target,
                          partial: "likes/private_button",
                          locals: {
                            product: @product,
                            like_status: current_user.liked?(@product)
                          })
  end
  
end