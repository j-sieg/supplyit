class AddFieldsToOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :address, :text, null: false, default: ""
    add_column :orders, :phone_number, :string, null: false, default: ""
  end
end
