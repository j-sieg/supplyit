class LineItemsController < ApplicationController
  include CurrentCart

  before_action :set_ordering

  def create
    product = Product.find(params[:product_id])

    unless product.available
      return respond_to do |format|
        format.html { redirect_to store_url, notice: "Product no longer available" }
        format.turbo_stream { render "products/replace", locals: { product: product } }
      end
    end

    @new_item = @current_cart.add_item(product)

    respond_to do |format|
      if @new_item.save!
        @added = true
        format.html { redirect_to products_url, notice: "Product " }
        format.turbo_stream { render "shared/update_cart_details" }
      end
    end
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
      format.html { redirect_to store_url }
      format.turbo_stream { render "shared/update_cart_details" }
    end
  end

  private
    def set_ordering
      @ordering = params[:ordering].present?
    end
end
