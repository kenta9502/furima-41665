class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :nickname, presence: true
  # ニックネームが入力されていない場合,Userインスタンスは無効,dbに保存できない
  validates :password, format: { with: /\A(?=.*[a-zA-Z])(?=.*\d).+\z/, message: 'must include both letters and numbers' }
  # 半角英数字が混在することを保証
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :first_name_kana, presence: true
  validates :last_name_kana, presence: true
  validates :birthday, presence: true
end
