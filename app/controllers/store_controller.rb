class StoreController < ApplicationController
  include CurrentCart
  before_action :set_product, only: [:show]

  def index
    products = case params[:category]
    in "" | nil
      Product.all.with_attached_images
    in String => category
      Category.find_by(name: category)&.products&.with_attached_images
    end

    render locals: { products: products, cart: @current_cart }
  end
end
