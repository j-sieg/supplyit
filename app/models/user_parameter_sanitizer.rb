class UserParameterSanitizer < Devise::ParameterSanitizer
  def initialize(*)
    super
    permit(:sign_up, keys: [:full_name, :phone_number, :address, :birthday])
    permit(:account_update, keys: [:full_name, :phone_number, :address, :birthday])
  end
end
