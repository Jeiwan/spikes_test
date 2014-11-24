class CreateAdminRequests < ActiveRecord::Migration
  def change
    create_table :admin_requests do |t|
      t.boolean :executed, default: false, null: false

      t.timestamps
    end
  end
end
