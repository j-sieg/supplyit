class CartsController < ApplicationController
  include CurrentCart

  def index
    render locals: { cart: @current_cart }
  end

  def destroy
    respond_to do |format|
      flash[:alert] = "Failed to destroy the cart" unless @current_cart.destroy
      format.html { redirect_to checkout_url }
      format.turbo_stream { render 'shared/update_cart' }
    end
  end
end
