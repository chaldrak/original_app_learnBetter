class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :question
  has_many :comments, dependent: :destroy
  mount_uploader :picture, ImageUploader
  validates :content, presence: true
  
end
