class LineItemsController < ApplicationController
  #calls the module CurrentCart - need to use exact name of module
  include CurrentCart

  #pulls this action from ???
  before_action :set_cart

  def create
    @skip_footer = true
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
    @skip_footer = true
    @line_item = Line_Item.find(params[:id])
    @line_item.destroy
    respond_to do |format|
      format.html { redirect_to cart_url, notice: 'Item was successfully deleted.' }
      format.json { head :no_content }
    end
  end

end
