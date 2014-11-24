class CreateProductStacks < ActiveRecord::Migration
  def change
    create_table :product_stacks do |t|
      t.integer :quantity

      t.timestamps
    end
  end
end
