class Product < ApplicationRecord
  validates_presence_of :name, :price, :location

  belongs_to :seller
  has_many :category_products, dependent: :destroy
  has_many :categories, through: :category_products
  has_many :line_items
  has_many_attached :images

  before_destroy :ensure_not_referenced_by_line_items

  validates :images, content_type: {
    in: %i[png jpg jpeg],
    message: 'Images should only be a PNG, JPG or JPEG'
  }

  def sold_count
    # count all line items in existence
    LineItem.where(product_id: id)
      .joins(:order)
      .where('orders.status = ?', Order.statuses['Completed'])
      .distinct
      .sum(:quantity)
  end

  def total_revenue
    sold_count * price
  end

  private
    def ensure_not_referenced_by_line_items
      unless line_items.empty?
        errors.add(:base, 'LineItems reference this product')
        throw :abort
      end
    end
end
