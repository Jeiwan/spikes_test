class AddQuantityAndQuantityThresholdToProducts < ActiveRecord::Migration
  def change
    add_column :products, :quantity, :integer, null: false
    add_column :products, :quantity_threshold, :integer, default: nil
  end
end
