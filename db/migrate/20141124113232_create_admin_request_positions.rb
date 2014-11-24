class CreateAdminRequestPositions < ActiveRecord::Migration
  def change
    create_table :admin_request_positions do |t|
      t.integer :article_id
      t.integer :request_id
      t.integer :quantity, null: false

      t.timestamps
    end

    add_index :admin_request_positions, :article_id
    add_index :admin_request_positions, :request_id
  end
end
