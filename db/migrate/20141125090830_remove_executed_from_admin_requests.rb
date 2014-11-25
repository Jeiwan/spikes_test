class RemoveExecutedFromAdminRequests < ActiveRecord::Migration
  def change
    remove_column :admin_requests, :executed
  end
end
