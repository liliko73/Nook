class CreateQuestionReactions < ActiveRecord::Migration[8.1]
  def change
    create_table :question_reactions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :question, null: false, foreign_key: true

      t.timestamps
    end

    # 1人のユーザーが1つの質問に対して作成できるリアクションを1つに限定する制約
    add_index :question_reactions, [ :user_id, :question_id ], unique: true
  end
end
