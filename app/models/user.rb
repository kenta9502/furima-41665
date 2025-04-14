class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :nickname, presence: true
  # ニックネームが入力されていない場合,Userインスタンスは無効隣,dbに保存できない
  validates :email, presence: true, format: { with: /\A[^@\s]+@[^@\s]+\z/, message: 'must contain @' }, uniqueness: true
  # アドレス必須,emailが特定の形式（＠を含む）に従っていることを保証,アドレスの重複防止
  validates :password, presence: true, length: { minimum: 6 },
                       format: { with: /\A(?=.*[a-zA-Z])(?=.*[0-9]).+\z/, message: 'must include both letters and numbers' }
  # パスワード必須,６文字以上,半角英数字が混在することを保証
  validate :passwords_must_match

  private

  def passwords_must_match
    return unless password.present? && password != password_confirmation

    errors.add(:password_confirmation, "doesn't match Password")
  end
end
