module ProductsHelper
  def available_message(product)
    product.available ? "Available" : "Unavailable"
  end

  def search_terms?
    params[:category].present? || params[:name].present?
  end

  def search_results_for
    case { category: params[:category], name: params[:name] }
      in { name: String => name, category: "" | nil }
        "\"#{name}\""
      in { category: String => category, name: "" | nil }
        "filtering products only in the #{category} category"
      in { category: String => category, name: String => name }
        "\"#{name}\" in the \"#{category}\" category"
    end
  end
end
