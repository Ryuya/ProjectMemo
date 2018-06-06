class Project < ApplicationRecord
  belongs_to :user
  has_many :questions
  has_many :question_categories ,dependent: :destroy
  validates :title , presence: true ,length: {maximum: 20}
  validates :project_category_id,presence: true
end
