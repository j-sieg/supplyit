class Seller < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :products

  # orders that have lineitems that reference the seller's products
  def orders
    line_items = LineItem.select(:id).where(product_id: products)
    Order.joins(:line_items).where('line_items.id IN (?)', line_items).group('orders.id')
  end
end
