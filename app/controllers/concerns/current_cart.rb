module CurrentCart
  extend ActiveSupport::Concern

  included do
    before_action :use_my_cart
  end

  protected

  def current_cart
    @current_cart
  end

  def set_cart
    @cart = Cart.find(session[:cart_id])
  rescue ActiveRecord::RecordNotFound
    @cart = Cart.create
    session[:cart_id] = @cart.id
  end

  def use_my_cart
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