class Category < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many(:product_relationships,
    class_name: 'CategoryProduct',
    foreign_key: :category_id,
    dependent: :destroy
  )
  has_many :products, through: :product_relationships
end
