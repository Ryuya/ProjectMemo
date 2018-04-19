class CreateQuestions < ActiveRecord::Migration[5.1]
  def change
    create_table :questions do |t|
      t.references :project, foreign_key: true
      t.references :user, foreign_key: true
      t.references :question_category, foreign_key: true
      t.string :title
      t.string :description
      t.boolean :resolution

      t.timestamps
    end
  end
end
