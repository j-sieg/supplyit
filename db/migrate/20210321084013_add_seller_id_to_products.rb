class AddSellerIdToProducts < ActiveRecord::Migration[6.1]
  def change
    add_reference :products, :seller, null: false, foreign_key: true
  end
end
