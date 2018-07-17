class QuestionsDatatable < TemplateDatatable


private

  
  def links(object)
    show_button(object).to_s+" "+evaluate_button(object).to_s+" "+edit_button(object).to_s
  end


  def edit_button(object)
    link_to("<i class=\"fa fa-edit no-margin-right\"></i> #{I18n.t('helpers.links.edit')}".html_safe,
      "#", data: {url: "/#{prefix_path(object)}/#{object.id}/edit"},
      :class => 'btn btn-ar btn-xs btn-info btn-edit') if @view.can?(:update, object) && object.question_status == QuestionStatus.find_by(name: "Denied") && @view.current_user.client?
  end

  def show_button(object)
    link_to("<i class=\"fa fa-eye no-margin-right\"></i> #{I18n.t('helpers.links.show')}".html_safe,
      "#", data: {url: "/#{prefix_path(object)}/#{object.id}"},
      :class => 'btn btn-ar btn-xs btn-info btn-edit') if @view.can?(:read, object)
  end


  def evaluate_button(object)
    link_to("<i class=\"fa fa-check no-margin-right\"></i> #{I18n.t('helpers.links.evaluate')}".html_safe,
      "#", data: {url: "/#{prefix_path(object)}/#{object.id}/evaluate_question"},
      :class => 'btn btn-ar btn-xs btn-info btn-edit') if @view.can?(:evaluate_question, object) && object.question_status == QuestionStatus.find_by(name: "Pending")
  end

  def sort_columns_collection
    ["id", "content", "source", "year", "users.name", "question_statuses.name"]
  end


  def data
    objects.map do |question|
      [
        question.id,
        question.content,
        question.source,
        question.year,
        question.user_name,
        question.question_status_name,
        links(question)
      ]
    end
  end

  def fetch_objects
    questions = Question.left_joins(:user,:question_status).includes(:user,:question_status).order("#{sort_column} #{sort_direction}")

    user_id = @view.current_user.id if @view.current_user.client?


    if params[:search][:value].present?
      conditions = []

      conditions << "(CAST(questions.id AS TEXT) LIKE ?)"
      conditions << "(UPPER(questions.content) LIKE UPPER(?))"
      conditions << "(UPPER(questions.source) LIKE UPPER(?))"
      conditions << "(UPPER(questions.year) LIKE UPPER(?))"
      conditions << "(UPPER(users.name) LIKE UPPER(?))"
      conditions << "(UPPER(question_statuses.name) LIKE UPPER(?))"

      values = []
      values <<  params[:search][:value]

      5.times do
        values << "%" + params[:search][:value] + "%"
      end

      conditions = ["(#{conditions.join(" or ")})"] + values
      conditions[0] <<  " AND user_id=#{user_id}" if user_id
    elsif user_id
      conditions = "user_id = #{user_id}"
    end

    questions.where(conditions).paginate(page: page, per_page: per_page).to_a
  end

end

