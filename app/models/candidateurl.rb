class Candidateurl < ApplicationRecord
  belongs_to :user
  belongs_to :question
  validates :url, presence: true
  validates :memo, presence: true

end
