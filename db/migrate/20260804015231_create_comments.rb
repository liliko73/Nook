class CreateComments < ActiveRecord::Migration[8.1]
  def change
    create_table :comments do |t|
      t.references :user, null: false, foreign_key: true
      t.references :theme, null: false, foreign_key: true
      t.integer :parent_id
      t.text :body, null: false

      t.timestamps
    end
    # 親コメントへの検索（返信機能）を考慮してインデックスを付与
    add_index :comments, :parent_id
  end
end
