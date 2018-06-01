class Project < ApplicationRecord
  belongs_to :user
  has_many :questions
  has_many :question_categories
  validates :title , presence: true ,length: {maximum: 20}
end
