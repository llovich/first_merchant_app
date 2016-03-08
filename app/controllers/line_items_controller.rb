class LineItemsController < ApplicationController
  #calls the module CurrentCart - need to use exact name of module
  include CurrentCart

  #pulls this action from ???
  before_action :set_cart

  def create
    product = Product.find(params[:product_id])
    @line_item = @cart.add_product(product.id)

    if @line_item.save
      flash[:notice] = "#{product.name} was successfully added to your cart!"
      redirect_to shop_url
    else
      flash.now[:alert] = "Could not add item to your cart."
      redirects_to :back
    end
  end

  def update
    @line_item = @cart.line_items.find(params[:id])

    if @line_item.quantity <= 0
      @line_item.destroy
      redirect_to edit_cart_path(@cart), notice: "Item removed from cart."
    elsif @line_item.update(line_item_params)
      redirect_to edit_cart_path(@cart), notice: "#{@line_item.product.name} quantity updated."
    else
      redirect_to edit_cart_path(@cart), alert: "Could not update quantity."
    end
  end

  def destroy
      item = @cart.line_items.find(params[:id])
      item.destroy
      #DO I NEED THIS SESSION STUFF?
      #session[:product_id] = nil
      #session[:quantity] = nil
      flash[:notice] = "Item was successfully deleted"
      redirect_to edit_cart_path(@cart)
  end

  private

  def line_item_params
    params.require(:line_item).permit(:quantity)
  end

end
