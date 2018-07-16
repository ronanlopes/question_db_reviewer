class RevisionHistory < ApplicationRecord
  belongs_to :user
  belongs_to :question
  belongs_to :question_status

  validate :check_denied_comment


  def check_denied_comment
  	if self.question_status == QuestionStatus.find_by(name: "Denied") && !self.comment.present?
  		self.errors.add :comment, I18n.t("errors.messages.comment_required")
  	end
  end


end
