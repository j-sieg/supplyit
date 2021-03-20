class AddFieldsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :full_name, :string, null: false
    add_column :users, :phone_number, :string, null: false
    add_column :users, :address, :text
    add_column :users, :birthday, :date
  end
end
