class CreateProductStacks < ActiveRecord::Migration
  def change
    create_table :product_stacks do |t|
      t.integer :product_id
      t.integer :quantity

      t.timestamps
    end

    add_index :product_stacks, :product_id
  end
end
