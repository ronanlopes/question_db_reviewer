class QuestionStatus < ApplicationRecord

	validates :name, presence: true

	def to_s
		self.name
	end

end
