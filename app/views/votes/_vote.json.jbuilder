json.extract! vote, :id, :user_id, :question_id, :answer_id, :note, :created_at, :updated_at
json.url vote_url(vote, format: :json)
