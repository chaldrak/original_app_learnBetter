class Job < ApplicationRecord
  validates :title, :content, :location, :deadline, presence: true
end
