class Post < ApplicationRecord
  validates :title, presence: true, length: {minimum:3, message: "shoooooooot"}
  validates :body, presence: true
  has_many :comments, dependent: :destroy
end
