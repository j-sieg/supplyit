class OrdersController < ApplicationController
  before_action :authenticate_user!
  include CurrentCart

  skip_before_action :set_current_cart, only: %i[index]
  before_action :set_order, only: %i[show]
  before_action :ensure_cart_is_loaded, only: %i[new create]

  def index
    render locals: { orders: current_user.orders.includes(line_items: :product) }
  end

  def new
    @ordering = true
    @order = current_user.orders.new
    render locals: { cart: @current_cart }
  end

  def show
    render locals: { order: @order }
  end

  def create
    default_status = { status: Order.statuses['Completed']}
    order = current_user.orders.new(order_params.merge(default_status))
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

    def order_params
      params.require(:order).permit(:pay_type, :address, :phone_number)
    end

    def ensure_cart_is_loaded
      redirect_to store_url, notice: "You can't order anything with an empty cart..." unless @current_cart.loaded?
    end
end
