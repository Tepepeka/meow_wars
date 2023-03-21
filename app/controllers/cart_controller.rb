class CartController < ApplicationController

  before_action :authenticate_user!

  def show
  
  end


  def add_single
    @product = Product.find(params[:id])
    current_orderable = @cart.orderables.find_by(product_id: @product.id)
    if current_orderable
      current_orderable.update(quantity: current_orderable.quantity + 1)
    else
      @cart.orderables.create(product: @product, quantity: 1)
    end
    
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [turbo_stream.replace('cart',
                                                  partial: 'cart/cart',
                                                  locals: { cart: @cart}),
                              turbo_stream.replace(@product)]
      end
    end
  end

  
  def remove_single
    @product = Product.find(params[:id])
    current_orderable = @cart.orderables.find_by(product_id: @product.id)
    if current_orderable
      if current_orderable.quantity > 1
        current_orderable.update(quantity: current_orderable.quantity - 1)
      else
        current_orderable.destroy
      end
    end

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [turbo_stream.replace('cart',
                                                  partial: 'cart/cart',
                                                  locals: { cart: @cart}),
                              turbo_stream.replace(@product)]
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
                              turbo_stream.replace(@product)]
      end
    end
  end


  def remove 
    Orderable.find(params[:id]).destroy
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace('cart',
                                                  partial: 'cart/cart',
                                                  locals: { cart: @cart}) 
      end      
    end
  end

end