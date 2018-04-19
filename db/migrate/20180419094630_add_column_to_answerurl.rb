class AddColumnToAnswerurl < ActiveRecord::Migration[5.1]
  def change
    add_column :answerurls, :title, :string
  end
end
