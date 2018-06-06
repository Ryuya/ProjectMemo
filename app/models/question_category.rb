class QuestionCategory < ApplicationRecord
  belongs_to :project
  validates :category_name,presence: true,length: {maximum: 20}
end
