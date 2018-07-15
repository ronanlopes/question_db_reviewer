class Question < ApplicationRecord

  belongs_to :question_status
  belongs_to :user
  has_many :choices

	accepts_nested_attributes_for :choices, limit: 5

  validates :content, :source, :year, presence: true
  validate :check_number_of_choices,


  def check_number_of_choices
  	if self.choices.select{|c| c.content.present?}.size != 5
  		self.errors.add :choices, I18n.t("errors.messages.number_of_choices")
  	end
  end

end
