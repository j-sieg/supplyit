class Product < ApplicationRecord
  validates_presence_of :name, :price, :location

  belongs_to :seller
  has_many :category_products, dependent: :destroy
  has_many :categories, through: :category_products
  has_many :line_items

  before_destroy :ensure_not_referenced_by_line_items

  private
    def ensure_not_referenced_by_line_items
      unless line_items.empty?
        errors.add(:base, 'LineItems reference this product')
        throw :abort
      end
    end
end
