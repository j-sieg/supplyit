class Product < ApplicationRecord
  validates_presence_of :name, :price, :location

  has_many(:category_relationships,
    class_name: 'CategoryProduct',
    foreign_key: :product_id,
    dependent: :destroy
  )
  has_many :categories, through: :category_relationships
end
