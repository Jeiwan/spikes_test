class CreateOrderPositions < ActiveRecord::Migration
  def change
    create_table :order_positions do |t|
      t.integer :article_id
      t.integer :order_id
      t.integer :quantity, null: false
      t.float :price, null: false

      t.timestamps
    end
    add_index :order_positions, :article_id
    add_index :order_positions, :order_id
  end
end
