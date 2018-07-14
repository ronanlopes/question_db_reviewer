class Question < ApplicationRecord
  belongs_to :question_status
  belongs_to :user
end
