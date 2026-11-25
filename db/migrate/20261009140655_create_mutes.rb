class CreateMutes < ActiveRecord::Migration[8.1]
  def change
    create_table :mutes do |t|
      t.references :muter, null: false, foreign_key: { to_table: :users }
      t.references :muted, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end

    # 同じユーザーを二重にミュートできないようにユニーク制約を追加
    add_index :mutes, [ :muter_id, :muted_id ], unique: true
  end
end
