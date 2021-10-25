class Question < ApplicationRecord

  before_create :set_solved_as_false

  belongs_to :user
  has_many :answers, dependent: :destroy
  has_many :comments
  has_many :favorites, dependent: :destroy
  has_many :votes, dependent: :destroy
  mount_uploader :picture, ImageUploader

  validates :title, length: {minimum: 20}
  validates :content, presence: true

  def set_solved_as_false
    self.solved = false
  end
  
end
