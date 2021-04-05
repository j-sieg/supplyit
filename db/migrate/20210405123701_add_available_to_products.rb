class AddAvailableToProducts < ActiveRecord::Migration[6.1]
  def change
    add_column :products, :available, :boolean, default: false
  end
end
