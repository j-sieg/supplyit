class ApplicationController < ActionController::Base
  include CustomDeviseParameterSanitizer
end
