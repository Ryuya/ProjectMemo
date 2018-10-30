class ProjectCategory < ApplicationRecord
  has_many :projects
  validates :category_name,presence: true,length: {maximum: 20}
end
