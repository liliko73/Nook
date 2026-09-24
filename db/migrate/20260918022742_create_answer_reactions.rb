class CreateAnswerReactions < ActiveRecord::Migration[8.1]
  def change
    create_table :answer_reactions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :answer, null: false, foreign_key: true
      t.integer :reaction_type, null: false

      t.timestamps
    end

    # 1人のユーザーが1つの回答に対して作成できるリアクションを1つに限定する制約
    add_index :answer_reactions, [ :user_id, :answer_id ], unique: true
  end
end
