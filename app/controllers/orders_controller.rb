class OrdersController < ApplicationController
  before_action :authenticate_user!
  include CurrentCart

  before_action :set_order, only: %i[show]
  before_action :ensure_cart_is_loaded, only: %i[new create]

  def index
    render locals: { orders: current_user.orders }
  end

  def new
    render locals: { cart: @current_cart }
  end

  def show
    render locals: { order: @order }
  end

  def create
    order = current_user.orders.new(status: Order.statuses['Processing'])
    order.transfer_items_from_cart(@current_cart)

    if order.save!
      redirect_to orders_url, notice: "Successfully created your order"
    else
      redirect_to checkout_url, notice: "Failed to create your order"
    end
  end

  private
    def set_order
      @order = current_user.orders.find(params[:id])
    end

    def ensure_cart_is_loaded
      redirect_to products_url, notice: "Your cart is empty!" unless @current_cart.loaded?
    end
end
