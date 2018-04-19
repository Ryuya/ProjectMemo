class CreateCandidateurls < ActiveRecord::Migration[5.1]
  def change
    create_table :candidateurls do |t|
      t.string :url
      t.string :memo
      t.references :user, foreign_key: true
      t.references :question, foreign_key: true

      t.timestamps
    end
  end
end
