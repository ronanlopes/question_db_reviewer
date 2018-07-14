class RevisionHistory < ApplicationRecord
  belongs_to :user
  belongs_to :question
  belongs_to :question_status
end
