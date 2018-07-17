class QuestionsController < ApplicationController

  before_action :set_question, only: [:show, :evaluate_question, :update_question_review, :edit, :update, :destroy]

  load_and_authorize_resource

  def flash_notice
    "#{I18n.t("activerecord.models.question.one")} #{I18n.t("activerecord.messages.#{action_name}_success")}"
  end

  def index
    respond_to do |format|
      format.html
      format.json { render json: QuestionsDatatable.new(view_context) }
    end
  end

  def new
    @question = Question.new
    5.times { @question.choices.build }
  end

  def edit
  end

  def create
    @question = Question.new(question_params)
    @question.question_status = QuestionStatus.find_by(name: "Pending")
    @question.user = current_user

    respond_to do |format|
      if @question.save
        redirect_action_success(format)
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      @question.question_status = QuestionStatus.find_by(name: "Pending")
      if @question.update(question_params)
        redirect_action_success(format)
      else
        format.html { render :edit }
      end
    end
  end

  def show

    render :show, :layout => !request.xhr?

  end

 def evaluate_question
    @revision_history = RevisionHistory.includes(:question).new(user: current_user, question: @question)
    render :evaluate_question, :layout => !request.xhr?
  end

  def update_question_review
    @revision_history = RevisionHistory.new(revision_params)
    @revision_history.user = current_user
    @revision_history.question = @question
    respond_to do |format|
      @question.question_status = @revision_history.question_status
      if @question.save && @revision_history.save
        format.html { redirect_to questions_path(question_status: "Pending"), notice: 'Question was successfully reviewed.' }
        format.json { render :show, status: :ok, location: @question }
      else
        format.html { render :evaluate_question }
        format.json { render json: (@revision_history.errors + @question.errors), status: :unprocessable_entity }
      end
    end
  end


private

  def redirect_action_success(format)
    format.html {
      redirect_to questions_path, notice: flash_notice
    }
  end

  def set_question
    @question = Question.find_by_id(params[:id] || params[:question_id])
  end


  # Never trust parameters from the scary internet, only allow the white list through.
  def question_params
    params.require(:question).permit(:content, :source, :year, :question_status_id, :user_id, 
      choices_attributes: [:id, :content, :correct]
    )
  end

  def revision_params
    params.require(:revision_history).permit(:comment, :question_status_id)
  end


end
