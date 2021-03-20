module Sellers
  class ApplicationController < ::ApplicationController
    before_action :authenticate_seller!
  end
end