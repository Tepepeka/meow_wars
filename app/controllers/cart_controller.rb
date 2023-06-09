class CartController < ApplicationController

  before_action :authenticate_user!

  def show
  
  end


  def add_remove_product
    @product = Product.find(params[:id])
    current_orderable = @cart.orderables.find_by(product_id: @product.id)
    if current_orderable
      current_orderable.destroy
    else
      @cart.orderables.create(product: @product, quantity: 1)
    end

    respond_to do |format|
    format.turbo_stream do
      render turbo_stream: [turbo_stream.replace('cart',
                                                partial: 'cart/cart',
                                                locals: { cart: @cart}),
                            turbo_stream.replace(@product),
                            turbo_stream.update('number_products_cart', sprintf('%.2f', @cart.total))]
      end
    end
  end


  def add 
    @product = Product.find(params[:id])
    quantity = params[:quantity].to_i
    current_orderable = @cart.orderables.find_by(product_id: @product.id)
    if current_orderable && quantity > 0
      current_orderable.update(quantity: quantity)
    elsif quantity <= 0
      current_orderable.destroy
    else
      @cart.orderables.create(product: @product, quantity: quantity)
    end

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [turbo_stream.replace('cart',
                                                  partial: 'cart/cart',
                                                  locals: { cart: @cart}),
                              turbo_stream.replace(@product),
                              turbo_stream.update('number_products_cart', sprintf('%.2f', @cart.total))]
      end
    end
  end


  def remove 
    Orderable.find(params[:id]).destroy
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [turbo_stream.replace('cart',
                                                  partial: 'cart/cart',
                                                  locals: { cart: @cart}),
                                                  turbo_stream.replace(@product),
                              turbo_stream.update('number_products_cart', sprintf('%.2f', @cart.total))]
      end      
    end
  end

end