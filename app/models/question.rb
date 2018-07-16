class Question < ApplicationRecord

  belongs_to :question_status
  belongs_to :user
  has_many :choices, dependent: :destroy
  has_many :revision_histories, dependent: :destroy

	accepts_nested_attributes_for :choices, limit: 5
	accepts_nested_attributes_for :revision_histories

  validates :content, :source, :year, presence: true

end
