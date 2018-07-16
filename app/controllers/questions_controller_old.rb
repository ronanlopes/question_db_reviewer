class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy, :evaluate_question, :update_question_review]
  load_and_authorize_resource

  # GET /questions
  # GET /questions.json
  # def index
  #   if params[:question_status]
  #     condition = {question_statuses: {name: params[:question_status]}}
  #   end

  #   @questions = current_user.client? ? current_user.questions.includes(:question_status).where(condition) : Question.all.includes(:question_status).where(condition)
  # end

  def index
    respond_to do |format|
      format.html
      format.json { render json: QuestionsDatatable.new(view_context) }
    end
  end

  # GET /questions/1
  # GET /questions/1.json
  def show
  end

  # GET /questions/new
  def new
    @question = Question.new
    5.times { @question.choices.build }
  end

  # GET /questions/1/edit
  def edit
  end

  # POST /questions
  # POST /questions.json
  def create
    @question = Question.new(question_params)
    @question.question_status = QuestionStatus.find_by(name: "Pending")
    @question.user = current_user

    respond_to do |format|
      if @question.save
        format.html { redirect_to @question, notice: 'Question was successfully created.' }
        format.json { render :show, status: :created, location: @question }
      else
        format.html { render :new }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /questions/1
  # PATCH/PUT /questions/1.json
  def update
    respond_to do |format|
      @question.question_status = QuestionStatus.find_by(name: "Pending")
      if @question.update(question_params)
        format.html { redirect_to @question, notice: 'Question was successfully updated.' }
        format.json { render :show, status: :ok, location: @question }
      else
        format.html { render :edit }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  def evaluate_question
    @revision_history = RevisionHistory.includes(:question).new(user: current_user, question: @question)
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
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id] || params[:question_id])
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
