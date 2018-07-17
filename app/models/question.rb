class Question < ApplicationRecord

  belongs_to :question_status
  belongs_to :user
  has_many :choices, dependent: :destroy
  has_many :revision_histories, dependent: :destroy

	accepts_nested_attributes_for :choices, limit: 5
	accepts_nested_attributes_for :revision_histories

  validates :content, :source, :year, presence: true
	validates_inclusion_of :year, :in => 1900..Date.today.year, message: I18n.t("errors.messages.invalid_year")

	delegate :name, to: :user, prefix: :user
	delegate :name, to: :question_status, prefix: :question_status

  before_validation :set_question_status
	validate :check_correct_answer

  def set_question_status
  	self.question_status = QuestionStatus.find_by(name: "Pending") if !self.question_status
	end

	def check_correct_answer
		if self.choices.present? && choices.select{|c| c.correct}.size < 1
			self.errors.add(:base, I18n.t("errors.messages.at_least_one_correct_answer"))
		end
	end



end
