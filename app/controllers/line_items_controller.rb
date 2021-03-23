class LineItemsController < ApplicationController
  include CurrentCart

  def create
    product = Product.find(params[:product_id])
    new_item = @current_cart.add_item(product)

    respond_to do |format|
      if new_item.save!
        format.html { redirect_to products_url }
        format.turbo_stream { render 'shared/update_cart' }
      end
    end
  end

  def update
  end

  def destroy
    line_item = @current_cart.line_items.find(params[:id])
    if line_item.quantity.eql?(1)
      line_item.destroy
    else
      line_item.quantity -= 1
      line_item.save!
    end

    respond_to do |format|
      format.html { redirect_to products_url }
      format.turbo_stream { render 'shared/update_cart' }
    end
  end
end
