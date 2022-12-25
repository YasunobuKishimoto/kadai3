class Book < ApplicationRecord
  #has_one_attached :image
  belongs_to :user

   #タイトルが存在しているかを確認するバリデーション
  validates :title, presence: true
  validates :body, presence: true

  #imageが存在しているかを確認するバリデーション
  #validates :image, presence: true
end
