class Choice < ApplicationRecord

  belongs_to :question

  validates :content, presence: true, allow_blank: false

  def to_s
  	"#{self.content} (#{self.correct ? I18n.t("layout.correct") : I18n.t("layout.wrong")})"
  end


end
