class CreateAdminInvoicePositions < ActiveRecord::Migration
  def change
    create_table :admin_invoice_positions do |t|
      t.integer :article_id
      t.integer :invoice_id
      t.integer :quantity
      t.float :price

      t.timestamps
    end

    add_index :admin_invoice_positions, :article_id
    add_index :admin_invoice_positions, :invoice_id
  end
end
