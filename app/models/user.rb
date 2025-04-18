class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :nickname, presence: true
  # ニックネームが入力されていない場合,Userインスタンスは無効,dbに保存できない
  validates :email, uniqueness: true

  validates :password, format: { with: /\A(?=.*[a-zA-Z])(?=.*\d).+\z/, message: 'must include both letters and numbers' }
  # 半角英数字が混在することを保証
end
