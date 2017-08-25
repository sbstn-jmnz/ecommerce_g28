class AddFieldsToOrder < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :quantity, :integer, default: 0
    add_column :orders, :price, :integer
  end
end
