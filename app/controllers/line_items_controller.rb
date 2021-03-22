class LineItemsController < ApplicationController
  include CurrentCart

  def create
    product = Product.find(params[:product_id])
    new_item = @current_cart.add_item(product)

    respond_to do |format|
      if new_item.save!
        format.html { redirect_to products_url }
      end
    end
  end

  def update
  end

  def destroy
  end
end
