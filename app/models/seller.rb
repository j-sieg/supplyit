class Seller < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :products

  # orders that have lineitems that reference the seller's products
  def orders
    Order.where(id: LineItem.where(product_id: products).select(:order_id))
  end
end
