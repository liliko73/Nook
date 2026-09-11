class CreateCommentReactions < ActiveRecord::Migration[8.1]
  def change
    create_table :comment_reactions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :comment, null: false, foreign_key: true
      t.integer :reaction_type, null: false

      t.timestamps
    end

    # 1人のユーザーが1つのコメントに対して作成できるリアクションを1つに限定する制約
    add_index :comment_reactions, [ :user_id, :comment_id ], unique: true
  end
end
