class ProductsController < ApplicationController
  include CurrentCart
  before_action :set_product, only: [:show]

  # GET /products
  def index
    search_params = { category: params[:category], name: params[:name] }
    products = Product.search(search_params)
    render locals: { products: products, cart: @current_cart }
  end

  # GET /products/1
  def show
    render locals: { product: @product }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.available.find(params[:id])
    end

end
