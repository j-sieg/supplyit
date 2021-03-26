class Category < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many :category_products, dependent: :destroy
  has_many :products, through: :category_products

  before_save { |category| category.name = category.name.downcase }

  def capitalized_name
    name.capitalize
  end
end
