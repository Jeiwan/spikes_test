class RemoveProductStackIdFromProducts < ActiveRecord::Migration
  def change
    remove_column :products, :product_stack_id
  end
end
