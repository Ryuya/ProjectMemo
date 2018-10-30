class QuestionCategory < ApplicationRecord
  belongs_to :project
  has_many :questions
  validates :category_name,presence: true,length: {maximum: 20}
end
