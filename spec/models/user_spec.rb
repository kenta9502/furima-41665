require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できる時'
    it '正しく入力されていれば登録できる' do
      expect(@user).to be_valid
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
    it '英字のみのパスワードでは登録できない' do
      user = FactoryBot.build(:user, password: 'password', password_confirmation: 'password')
      user.valid?
      expect(user.errors.full_messages).to include('Password must include both letters and numbers')
    end
    it '数字のみのパスワードでは登録できない' do
      @user.password = @user.password_confirmation = '12345678'
      expect(@user).not_to be_valid
      expect(@user.errors.full_messages).to include('Password must include both letters and numbers')
    end
    it '全角文字を含むパスワードでは登録できない' do
      @user.password = @user.password_confirmation = 'password全角文字'
      expect(@user).not_to be_valid
      expect(@user.errors.full_messages).to include('Password must include both letters and numbers')
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
    it '姓名（全角）に半角文字が含まれていると登録できない' do
      @user.last_name = 'Yamada'
      expect(@user).not_to be_valid
      expect(@user.errors.full_messages).to include('Last name は全角の漢字・ひらがな・カタカナのみで入力してください')
    end
    it '名前（全角）に半角文字が含まれていると登録できない' do
      @user.first_name = 'Taro'
      expect(@user).not_to be_valid
      expect(@user.errors.full_messages).to include('First name は全角の漢字・ひらがな・カタカナのみで入力してください')
    end
    it '平仮名を含む姓名（カナ）では登録できない' do
      @user.last_name_kana = 'やまだ'
      expect(@user).not_to be_valid
      expect(@user.errors.full_messages).to include('Last name kana は全角カタカナのみで入力してください')
    end

    it '漢字を含む姓名（カナ）では登録できない' do
      @user.last_name_kana = '山田'
      expect(@user).not_to be_valid
      expect(@user.errors.full_messages).to include('Last name kana は全角カタカナのみで入力してください')
    end

    it '英字を含む姓名（カナ）では登録できない' do
      @user.last_name_kana = 'Yamada'
      expect(@user).not_to be_valid
      expect(@user.errors.full_messages).to include('Last name kana は全角カタカナのみで入力してください')
    end

    it '記号を含む姓名（カナ）では登録できない' do
      @user.last_name_kana = 'ヤマダ@'
      expect(@user).not_to be_valid
      expect(@user.errors.full_messages).to include('Last name kana は全角カタカナのみで入力してください')
    end
    it '平仮名を含む名前（カナ）では登録できない' do
      @user.first_name_kana = 'たろう'
      expect(@user).not_to be_valid
      expect(@user.errors.full_messages).to include('First name kana は全角カタカナのみで入力してください')
    end
    it '漢字を含む名前（カナ）では登録できない' do
      @user.first_name_kana = '太郎'
      expect(@user).not_to be_valid
      expect(@user.errors.full_messages).to include('First name kana は全角カタカナのみで入力してください')
    end
    it '英字を含む名前（カナ）では登録できない' do
      @user.first_name_kana = 'Taro'
      expect(@user).not_to be_valid
      expect(@user.errors.full_messages).to include('First name kana は全角カタカナのみで入力してください')
    end
    it '記号を含む名前（カナ）では登録できない' do
      @user.first_name_kana = 'タロウ@'
      expect(@user).not_to be_valid
      expect(@user.errors.full_messages).to include('First name kana は全角カタカナのみで入力してください')
    end
    it '生年月日が空だと登録できない' do
      @user.birthday = nil
      expect(@user).not_to be_valid
      expect(@user.errors.full_messages).to include("Birthday can't be blank")
    end
  end
end
