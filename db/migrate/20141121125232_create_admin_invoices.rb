class CreateAdminInvoices < ActiveRecord::Migration
  def change
    create_table :admin_invoices do |t|
      t.timestamps
    end
  end
end
