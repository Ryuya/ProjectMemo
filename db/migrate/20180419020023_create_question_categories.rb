class CreateQuestionCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :question_categories do |t|
      t.string :category_name

      t.timestamps
    end
  end
end
