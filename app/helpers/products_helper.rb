module ProductsHelper
  def no_products_message
    if category = params[:category]
      "There are no products in #{category}"
    else
      "There are no products"
    end
  end
end
