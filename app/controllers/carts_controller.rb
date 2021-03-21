class CartsController < ApplicationController
  include CurrentCart

  def index
    render locals: { cart: @current_cart }
  end

  def destroy
    if @current_cart.destroy
      redirect_to checkout_url, notice: "Your cart has been emptied"
    end
  end
end