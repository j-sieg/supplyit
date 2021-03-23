class Order < ApplicationRecord
  belongs_to :user
  has_many :line_items, -> { includes :product }, dependent: :destroy

  enum status: %w[Canceled Processing Completed]
  enum pay_type: {
    'Credit Card': 0,
    'Debit Card': 1,
    'Gcash': 2
  }

  validates :status, presence: true

  def transfer_items_from_cart(cart)
    cart.line_items.each do |line_item|
      line_item.cart_id = nil
      line_items << line_item
    end
  end

  def total_cost
    line_items.map { |item| item.total_price }.sum
  end
end
