json.extract! question, :id, :content, :source, :year, :question_status_id, :user_id, :created_at, :updated_at
json.url question_url(question, format: :json)
