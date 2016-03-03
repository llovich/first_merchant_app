class LineItemsController < ApplicationController
  #calls the module CurrentCart - need to use exact name of module
  include CurrentCart

  #pulls this action from ???
  before_action :set_cart

  def create
    product = Product.find(params[:product_id])
    @line_item = @cart.line_items.build(product: product, price: product.current_price)

    if @line_item.save
      flash[:notice] = "#{product.name} was successfully added to your cart!"
      redirect_to shop_url
    else
      flash.now[:alert] = "Could not add item to your cart."
      redirects_to :back
    end
  end

  def destroy
      item = @cart.line_items.find(params[:id])
      item.destroy
      #DO I NEED THIS SESSION STUFF?
      #session[:product_id] = nil
      #session[:quantity] = nil
      flash[:notice] = "Item was successfully deleted"
      redirect_to shop_url
  end

end
