class DropProductStacks < ActiveRecord::Migration
  def change
    drop_table :product_stacks
  end
end
