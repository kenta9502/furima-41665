require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できる時'
    it 'nicknameとemail、passwordとpassword_confirmationが存在すれば登録できる' do
    end
  end
  context '新規登録できないとき' do
    it 'nicknameが空では登録できない' do
      @user.nickname = '' # nicknameの値を空にする
      @user.valid?
      expect(@user.errors.full_messages).to include("Nickname can't be blank")
    end
    it 'emailが空では登録できない' do
      @user.email = '' # emailの値を空にする
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end
    it 'パスワードが空では登録できない' do
      @user.password = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end
    it 'パスワードが６文字以上でないと登録できない' do
      @user.password = @user.password_confirmation = 'abc12'
      expect(@user).not_to be_valid
      expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
    end
    it 'パスワードが英数字でない場合はエラーが発生します' do
      @user.password = @user.password_confirmation = 'password'
      expect(@user).not_to be_valid
      expect(@user.errors[:password]).to include('must include both letters and numbers')
    end
    it 'パスワードとパスワード（確認）は値の一致が必須' do
      @user.password = '123456'
      @user.password_confirmation = '1234567'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
    it '重複したemailが存在する場合は登録できない' do
      @user.save
      user_with_same_email = FactoryBot.build(:user, email: @user.email)
      expect(user_with_same_email).not_to be_valid
      expect(user_with_same_email.errors.full_messages).to include('Email has already been taken')
    end
    it '姓名が空では登録できない' do
      @user.first_name = nil
      expect(@user).not_to be_valid
      expect(@user.errors.full_messages).to include("First name can't be blank")
    end

    it '名前が空では登録できない' do
      @user.last_name = nil
      expect(@user).not_to be_valid
      expect(@user.errors.full_messages).to include("Last name can't be blank")
    end
    it '姓名（カナ）が空では登録できない' do
      @user.first_name_kana = nil
      expect(@user).not_to be_valid
      expect(@user.errors.full_messages).to include("First name kana can't be blank")
    end

    it '名前（カナ）が空では登録できない' do
      @user.last_name_kana = nil
      expect(@user).not_to be_valid
      expect(@user.errors.full_messages).to include("Last name kana can't be blank")
    end
  end
end
