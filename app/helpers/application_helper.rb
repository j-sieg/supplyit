module ApplicationHelper
  def field_error(object, attr)
    errors = object.errors[attr.to_sym]
    if errors.any?
      content_tag :span, class: "text-danger mt-2" do
        errors.to_sentence
      end
    end
  end
end
