class OrdersController < ApplicationController
 include CurrentCart

 #makes user sign in bf any of below view
  before_action :authenticate_user!
  before_action :set_cart, only: [:new, :create]

  def new
     @skip_footer = true
     #redirects user from order if the cart is empty
     if @cart.line_items.empty?
        redirect_to shop_url, notice: "Your cart is empty."
        #place this returen to skip stuff underneath
        return
     end
     @order = Order.new
  end

 def create
    @order = current_user.orders.build(order_params)
    if @order.save
      # Move items from cart to order
      @order.add_line_items_from_cart(@cart.id)

      # Destroy the cart and reset the session cart_id
      @cart.destroy
      session[:cart_id] = nil

      # Redirect and confirmation notice
      redirect_to @order, notice: "Thank you for your order!"
    else
      render :new
    end
  end

  def show
     @skip_footer = true
    # TODO: deny access to orders to other users
    @order = Order.find(params[:id])
  end

  private

  def order_params
    params.require(:order).permit(:shipping_name, :shipping_address, :payment_type)
  end
end
