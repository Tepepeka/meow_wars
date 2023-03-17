class ApplicationController < ActionController::Base

  before_action :set_render_cart
  before_action :initialize_cart
 
  def set_render_cart
    @render_cart = true
  end

  def initialize_cart
    if user_signed_in?
    @cart ||= current_user.cart
      if @cart.nil?
        @cart = Cart.create(user_id: current_user.id)
      end
    end
  end

end
