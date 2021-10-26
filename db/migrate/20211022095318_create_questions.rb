class CreateQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :questions do |t|
      t.string :title, null: false
      t.string :content, null: false
      t.text :picture
      t.references :user, foreign_key: true
      t.boolean :solved, default: false
      t.integer :answer_id

      t.timestamps
    end
  end
end
