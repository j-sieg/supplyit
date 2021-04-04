module CustomDeviseParameterSanitizer
  extend ActiveSupport::Concern

  included do
    protected
      def devise_parameter_sanitizer
        if resource_class.eql?(User)
          User::ParameterSanitizer.new(User, :user, params)
        else
          super
        end
      end
  end
end