class Question < ApplicationRecord

  belongs_to :question_status
  belongs_to :user
  has_many :choices, dependent: :destroy
  has_many :revision_histories, dependent: :destroy

	accepts_nested_attributes_for :choices, limit: 5
	accepts_nested_attributes_for :revision_histories

  validates :content, :source, :year, presence: true

  before_update :set_pending_status


  #could use a observer if the logic grows too much
  def set_pending_status
  	self.question_status = QuestionStatus.find_or_create_by(name: "Pending")
  end


end
