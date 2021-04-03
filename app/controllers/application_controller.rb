class ApplicationController < ActionController::Base
  include CustomDeviseParameterSanitizer

  protected
    def after_sign_in_path_for(resource)
      return store_url if resource.is_a?(User)
      sellers_products_url if resource.is_a?(Seller)
    end

    def after_sign_out_path_for(scope)
      case scope
      when :user
        new_user_session_url
      when :seller
        new_seller_session_url
      end
    end
end
