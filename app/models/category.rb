class Category < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many :category_products, dependent: :destroy
  has_many :products, through: :category_products
end
