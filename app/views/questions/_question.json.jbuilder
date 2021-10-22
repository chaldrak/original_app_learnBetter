json.extract! question, :id, :title, :content, :picture, :user_id, :solved, :answer_id, :created_at, :updated_at
json.url question_url(question, format: :json)
