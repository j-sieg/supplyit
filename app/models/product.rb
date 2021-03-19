class Product < ApplicationRecord
  validates_presence_of :name, :price, :location

  has_many :category_products, dependent: :destroy
  has_many :categories, through: :category_products
end
