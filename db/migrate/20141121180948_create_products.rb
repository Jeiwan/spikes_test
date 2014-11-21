class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.float :price
      t.integer :product_stack_id

      t.timestamps
    end
    
    add_index :products, :product_stack_id
  end
end
