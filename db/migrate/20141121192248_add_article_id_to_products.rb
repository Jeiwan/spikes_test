class AddArticleIdToProducts < ActiveRecord::Migration
  def change
    add_column :products, :article_id, :integer
    add_index :products, :article_id
  end
end
