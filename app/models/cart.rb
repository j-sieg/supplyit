class Cart < ApplicationRecord
  belongs_to :user, optional: true
  has_many :line_items, dependent: :destroy

  def add_item(product)
    if item = self.line_items.find_by(product_id: product.id)
      item.quantity += 1
    else
      item = self.line_items.new(product_id: product.id)
      item.price = product.price
    end
    item
  end

  def total_price
    line_items.to_a.sum { |item| item.total_price }
  end

  def loaded?
    line_items.any?
  end

  def empty?
    line_items.empty?
  end
end
