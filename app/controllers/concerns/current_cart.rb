module CurrentCart
  extend ActiveSupport::Concern

  included do
    before_action :set_current_cart
  end

  protected

  def set_cart
    @cart = Cart.includes(line_items: :product).find(session[:cart_id])
  rescue ActiveRecord::RecordNotFound
    @cart = Cart.create
    session[:cart_id] = @cart.id
  end

  def set_current_cart
    if user_cart = current_user&.cart
      @current_cart = user_cart
    elsif user_signed_in? && (!current_user.cart)
      set_cart
      @current_cart = current_user.cart = @cart
    else
      set_cart
      @current_cart = @cart
    end
  end

end