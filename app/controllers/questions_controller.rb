class QuestionsController < ApplicationController

  before_action :set_test, only: [:edit, :update, :destroy]

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
  end

  def edit
  end

  def create
    @question = Question.new(question_params)

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
      if @question.update(question_params)
        redirect_action_success(format)
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @question.destroy
    respond_to do |format|
      redirect_action_success(format)
    end
  end


private

  def redirect_action_success(format)
    format.html {
      redirect_to tests_path, notice: flash_notice
    }
  end

  def set_test
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:test).permit(:content, :source, :year, :question_status_id, :user_id_id)
  end

end
