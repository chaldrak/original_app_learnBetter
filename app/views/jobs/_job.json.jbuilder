json.extract! job, :id, :title, :content, :location, :deadline, :created_at, :updated_at
json.url job_url(job, format: :json)
