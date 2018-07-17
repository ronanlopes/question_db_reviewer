class QuestionStatus < ApplicationRecord

	validates :name, presence: true

	scope :review, -> { where(name: ["Approved", "Denied"]) }

	def to_s
		self.name
	end

end
