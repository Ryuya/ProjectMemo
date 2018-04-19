class CreateQuestionTags < ActiveRecord::Migration[5.1]
  def change
    create_table :question_tags do |t|
      t.references :question, foreign_key: true
      t.string :tag_name

      t.timestamps
    end
  end
end
