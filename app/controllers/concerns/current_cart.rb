module CurrentCart
  extend ActiveSupport::Concern

  included do
    before_action :set_current_cart
  end

  protected

  def set_cart
    @cart = Cart.find(session[:cart_id])
  rescue ActiveRecord::RecordNotFound
    @cart = Cart.create
    session[:cart_id] = @cart.id
  end

  def set_current_cart
    if current_user&.cart
      @current_cart = current_user.cart
      session.delete(:cart_id)
      return
    end

    set_cart

    if user_signed_in?
      # authenticated w/ no cart
      @current_cart = current_user.cart = @cart
    else
      # unauthenticated
      @current_cart = @cart
    end
  end

end