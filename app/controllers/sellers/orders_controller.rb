module Sellers
  class OrdersController < ApplicationController

    def index
      orders = current_seller.orders.includes(:line_items).group("line_items.id")
      render locals: { orders: orders }
    end

    def show
      @order =
        Order.includes(:user, line_items: :product)
        .where(line_items: { product_id: current_seller.products })
        .find(params[:id])

      render locals: { order: @order }
    end
  end
end