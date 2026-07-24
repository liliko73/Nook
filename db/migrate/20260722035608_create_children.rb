class CreateChildren < ActiveRecord::Migration[8.1]
  def change
    create_table :children do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :birthday_year
      t.integer :birthday_month
      t.integer :birthday_date
      t.integer :gender

      t.timestamps
    end
  end
end
