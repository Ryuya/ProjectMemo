class Candidateurl < ApplicationRecord
  belongs_to :user
  belongs_to :question
  # ^ は行頭 $ は行末
  # \A は文頭 \z は文末

  URL_REGEXP = /\Ahttps?:\/\/([0-9a-zA-Z_-]+\.)+[0-9a-zA-Z_-]+(\/[0-9a-zA-Z_\-.\/?%&=]*)?\z/
  validates :title,presence: true
  validates :url, presence: true, format: URL_REGEXP
  validates :memo, presence: true

end
