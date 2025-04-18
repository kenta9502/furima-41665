class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :nickname, presence: true
  # ニックネームが入力されていない場合,Userインスタンスは無効,dbに保存できない
  validates :password, format: { with: /\A(?=.*[a-zA-Z])(?=.*\d).+\z/, message: 'must include both letters and numbers' }
  # 半角英数字が混在することを保証
  validates :first_name, presence: true, format: { with: /\A[ぁ-んァ-ン一-龥]+\z/, message: 'は全角の漢字・ひらがな・カタカナのみで入力してください' }
  validates :last_name,  presence: true, format: { with: /\A[ぁ-んァ-ン一-龥]+\z/, message: 'は全角の漢字・ひらがな・カタカナのみで入力してください' }
  validates :first_name_kana, presence: true, format: { with: /\A[\p{katakana}ー－]+\z/, message: 'は全角カタカナのみで入力してください' }
  validates :last_name_kana, presence: true, format: { with: /\A[\p{katakana}ー－]+\z/, message: 'は全角カタカナのみで入力してください' }
  validates :birthday, presence: true
end
