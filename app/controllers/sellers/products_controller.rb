module Sellers
  class ProductsController < ApplicationController
    before_action :set_product, except: %i[index new create]

    def index
      render locals: { products: current_seller.products }
    end

    def show
      render locals: { product: @product }
    end

    # GET /products/new
    def new
      @product = current_seller.products.new
    end

    # GET /products/1/edit
    def edit
    end

    # POST /products
    def create
      @product = current_seller.products.new(product_params)

      if @product.save
        redirect_to sellers_product_url(@product), notice: 'Product was successfully created.'
      else
        render :new
      end
    end

    # PATCH/PUT /products/1
    def update
      if @product.update(product_params)
        redirect_to sellers_product_url(@product), notice: 'Product was successfully updated.'
      else
        render :edit
      end
    end

    # DELETE /products/1
    def destroy
      @product.destroy
      redirect_to sellers_products_url, notice: 'Product was successfully destroyed.'
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_product
        @product = current_seller.products.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def product_params
        params.require(:product).permit(:name, :price, :location, category_ids: [])
      end
  end
end
