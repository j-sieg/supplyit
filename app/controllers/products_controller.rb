class ProductsController < ApplicationController
  include CurrentCart
  before_action :set_product, only: [:show]

  # GET /products
  def index
    products = Product.all.with_attached_images
    render locals: { products: products, cart: @current_cart }
  end

  # GET /products/1
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

end
