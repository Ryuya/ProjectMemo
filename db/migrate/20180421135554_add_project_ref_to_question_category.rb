class AddProjectRefToQuestionCategory < ActiveRecord::Migration[5.1]
  def change
    add_reference :question_categories, :project, foreign_key: true
  end
end
