class AddRequestIdToAdminInvoices < ActiveRecord::Migration
  def change
    add_column :admin_invoices, :request_id, :integer
    add_index :admin_invoices, :request_id
  end
end
