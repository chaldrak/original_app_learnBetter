class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :question
  mount_uploader :picture, ImageUploader
  validates :content, presence: true
  
end
