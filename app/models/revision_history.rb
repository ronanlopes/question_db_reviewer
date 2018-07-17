class RevisionHistory < ApplicationRecord
  belongs_to :user
  belongs_to :question
  belongs_to :question_status

  validate :check_denied_comment
  validate :check_pendent_question

  def check_denied_comment
  	if self.question_status == QuestionStatus.find_by(name: "Denied") && !self.comment.present?
  		self.errors.add :comment, I18n.t("errors.messages.comment_required")
  	end
  end

  def check_pendent_question
  	if self.question.question_status != QuestionStatus.find_by(name: "Pendent")
  		self.errors.add :question_status_id, I18n.t("errors.messages.cant_evaluate_not_pending")
  	end
  end


end
