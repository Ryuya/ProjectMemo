class Question < ApplicationRecord
  belongs_to :user
  belongs_to :project
  has_many :candidateurls ,dependent: :destroy# class_name: 'Candidateurl'#:optional => true
  has_many :answerurls ,dependent: :destroy
  
  validates :title , presence: true ,length: {maximum: 20}
  validates :description , presence: true ,length: {maximum: 300}
end
