class QuestionsDatatable < TemplateDatatable


private

  def data
    objects.map do |question|
      [
        question.id,
        question.content,
        question.source,
        question.year,
        links(question)
      ]
    end
  end

  def fetch_objects
    questions = Question.order("#{sort_column} #{sort_direction}")

    if params[:search][:value].present?
      conditions = []

      conditions << "(CAST(questions.id AS TEXT) LIKE ?)"
      conditions << "(UPPER(questions.content) LIKE UPPER(?))"
      conditions << "(UPPER(questions.source) LIKE UPPER(?))"
      conditions << "(UPPER(questions.year) LIKE UPPER(?))"

      values = []
      values <<  params[:search][:value]

      3.times do
        values << "%" + params[:search][:value] + "%"
      end

      conditions = ["(#{conditions.join(" or ")})"] + values
    end

    questions.where(conditions).paginate(page: page, per_page: per_page).to_a
  end

end

