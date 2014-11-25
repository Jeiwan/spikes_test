class AddQuantityThrehsoldToProductStacks < ActiveRecord::Migration
  def change
    add_column :product_stacks, :quantity_threshold, :integer, default: nil
  end
end
