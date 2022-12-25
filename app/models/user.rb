class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

    #「1:Nの1側が削除されたとき、N側を全て削除する」という機能が追加されます。
  #ほとんどの場合「has_many」には「dependent: :destroy」を付けて実装するのでセットで覚えておきましょう。
   has_many :book, dependent: :destroy
  # has_many :, dependent: :destroy
  # has_many :, dependent: :destroy

  #has_one_attached :profile_imageという記述により、profile_imageという名前でActiveStorageで
  #プロフィール画像を保存できるように設定
   has_one_attached :profile_image

  # バリデーション
  validates :name, presence: true,length: { minimum: 2, maximum: 20 }

  # 共通処理 メソッドに対して引数を設定し、引数に設定した値に画像のサイズを変換する
  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end
end
