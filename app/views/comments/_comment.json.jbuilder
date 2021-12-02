json.extract! comment, :id, :content, :question_id, :answer_id, :user_id, :created_at, :updated_at
json.url comment_url(comment, format: :json)
