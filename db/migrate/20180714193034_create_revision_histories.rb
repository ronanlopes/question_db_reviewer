class CreateRevisionHistories < ActiveRecord::Migration[5.2]
  def change
    create_table :revision_histories do |t|
      t.references :user, foreign_key: true
      t.references :question, foreign_key: true
      t.references :question_status, foreign_key: true

      t.timestamps
    end
  end
end
