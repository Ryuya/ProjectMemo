class CreateAnswerurls < ActiveRecord::Migration[5.1]
  def change
    create_table :answerurls do |t|
      t.string :url
      t.string :memo
      t.references :user, foreign_key: true
      t.references :question, foreign_key: true
      t.integer :answer_index

      t.timestamps
    end
  end
end
