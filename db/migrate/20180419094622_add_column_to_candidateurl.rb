class AddColumnToCandidateurl < ActiveRecord::Migration[5.1]
  def change
    add_column :candidateurls, :title, :string
  end
end
