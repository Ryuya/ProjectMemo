class Question < ApplicationRecord
  belongs_to :user
  belongs_to :project
  has_many :candidateurls# class_name: 'Candidateurl'#:optional => true
  has_many :answerurls
end
