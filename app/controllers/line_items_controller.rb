class LineItemsController < ApplicationController
  include CurrentCart

  before_action :set_ordering

  def create
    product = Product.available.find(params[:product_id])
    @new_item = @current_cart.add_item(product)

    respond_to do |format|
      if @new_item.save!
        @added = true
        format.html { redirect_to products_url }
        format.turbo_stream do
          render locals: { product: product }
        end
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
      format.html { redirect_to products_url }
      format.turbo_stream { render 'shared/update_cart' }
    end
  end

  private
    def set_ordering
      @ordering = params[:ordering].present?
    end
end
