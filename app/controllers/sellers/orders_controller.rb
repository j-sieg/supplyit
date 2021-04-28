module Sellers
  class OrdersController < ApplicationController

    def index
      orders = current_seller.orders
      render locals: { orders: orders }
    end

    def show
      @order =
        Order.with_items_from(seller: current_seller)
          .includes(:user, line_items: :product).find(params[:id])

      render locals: { order: @order }
    end
  end
end