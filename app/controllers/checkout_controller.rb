class CheckoutController < ApplicationController

  def create
    @total = params[:total].to_d
    @session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [
        {
          price_data: {
            currency: 'eur',
            unit_amount: (@total*100).to_i,
            product_data: {
              name: 'Rails Stripe Checkout',
            },
          },
          quantity: 1
        },
      ],
      mode: 'payment',
      success_url: checkout_success_url + '?session_id={CHECKOUT_SESSION_ID}',
      cancel_url: checkout_cancel_url
    )
    redirect_to @session.url, allow_other_host: true
  end

  def success
    @session = Stripe::Checkout::Session.retrieve(params[:session_id])
    @payment_intent = Stripe::PaymentIntent.retrieve(@session.payment_intent)

      # create a new order for the user
      @total = @cart.total
      @order = current_user.orders.create(
        total: @total.to_d,
        payment_date: Time.now
      )
  
      # add order details (products) to the order
      @cart.orderables.each do |orderable|
        @order.order_products.create(
          product: orderable.product,
          quantity: orderable.quantity,
          price: orderable.product.price
        )
      end
  
      # clear the user's cart after order is created
      @cart.orderables.destroy_all
  
      # redirect to order confirmation page
      redirect_to root_path
      
  end

  def cancel
  end

end