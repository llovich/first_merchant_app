class CartsController < ApplicationController
  #calls the module CurrentCart - need to use exact name of module
  include CurrentCart

  #pulls this action from ???

  before_action :set_cart
  def edit
     @skip_footer = true
  end

  def update
    @skip_footer = true
  end

  def destroy
    if @cart.destroy
      session[:cart_id] = nil
      flash[:notice] = "Cart successfully deleted"
      redirect_to shop_url
    else
      flash[:alert] = "Could not delete cart."
      redirect_to edit_cart_url
    end
  end

end
