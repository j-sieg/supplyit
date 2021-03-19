module ApplicationHelper
  def field_error(object, attr)
    errors = object.errors[attr.to_sym]
    return errors.to_sentence if errors.any?
  end
end
