class LineItemsController < ApplicationController
  include CurrentCart

  def create
    product = Product.find(params[:product_id])
    new_item = @current_cart.add_item(product)


    respond_to do |format|
      if new_item.save!
        # reloading efficiently
        @current_cart = Cart.includes(line_items: :product).find(@current_cart.id)
        format.html { redirect_to products_url }
        format.turbo_stream
      end
    end
  end

  def update
  end

  def destroy
  end
end
