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
    return @current_cart = current_user.cart if current_user&.cart&.loaded?

    set_cart

    # replace the user's empty cart with the loaded one
    if current_user&.cart&.empty? && @cart.loaded?
      current_user.cart = @cart
      return @current_cart = @cart
    end

    if user_signed_in? && (!current_user.cart)
      # authenticated w/ no cart
      @current_cart = current_user.cart = @cart
    else
      # unauthenticated
      @current_cart = @cart
    end
  end

end