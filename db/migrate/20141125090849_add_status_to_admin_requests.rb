class AddStatusToAdminRequests < ActiveRecord::Migration
  def change
    add_column :admin_requests, :status, :integer, default: 0, null: false
    add_index :admin_requests, :status
  end
end
