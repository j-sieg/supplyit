class StoreController < ApplicationController
  include CurrentCart
  before_action :set_product, only: [:show]

  def index
    render locals: { cart: @current_cart }
  end
end
