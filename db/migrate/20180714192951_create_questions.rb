class CreateQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :questions do |t|
      t.text :content
      t.string :source
      t.integer :year
      t.references :question_status, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
