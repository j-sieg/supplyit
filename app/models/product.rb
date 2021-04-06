class Product < ApplicationRecord
  validates_presence_of :name, :price, :location

  belongs_to :seller
  has_many :category_products, dependent: :destroy
  has_many :categories, through: :category_products
  has_many :line_items
  has_many_attached :images

  default_scope { order(updated_at: :desc) }

  scope :available,   -> { where(available: true) }
  scope :unavailable, -> { where(available: false) }

  before_destroy :ensure_not_referenced_by_line_items

  validates :images, content_type: {
    in: %i[png jpg jpeg],
    message: 'Images should only be a PNG, JPG or JPEG'
  }

  def self.search(params = { category: nil, name: nil })
    case params
    in { category: String => category, name: "" | nil }
      Category.find_by(name: category)&.products&.available&.with_attached_images
    in { name: String => name, category: "" | nil }
      Product.available.where('name ILIKE ?', "%#{name}%").with_attached_images
    in { category: String => category, name: String => name }
      Category.find_by(name: category)\
        &.products&.available&.where('name ILIKE ?', "%#{name}%")&.with_attached_images
    else
      Product.available.with_attached_images
    end
  end

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
