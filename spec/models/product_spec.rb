require 'rails_helper'

RSpec.describe Product, type: :model do
  before do
    @product = FactoryBot.build(:product)
  end
  describe '商品の出品' do
    context '商品の出品ができる時'
    it '正しく入力されていれば出品できる' do
      expect(@product).to be_valid
    end
    it '価格が¥300以上¥9,999,999以下の場合出品できる' do
      expect(@product).to be_valid
    end

    context '出品できないとき' do
      it '商品画像が1枚ないと出品できない' do
        @product.image = '' # imageの値を空にする
        @product.valid?
        expect(@product.errors.full_messages).to include('Image must be attached')
      end
      it '商品名が空では出品できない' do
        @product.name = '' # nameの値を空にする
        @product.valid?
        expect(@product.errors.full_messages).to include('Product name cannot be blank')
      end
      it '商品説明がないと出品できない' do
        @product.description = '' # descriptionの値を空にする
        @product.valid?
        expect(@product.errors.full_messages).to include('Product description cannot be blank')
      end
      it 'カテゴリー情報ないと出品できない' do
        @product.category_id = 1
        @product.valid?
        expect(@product.errors.full_messages).to include('Category information cannot be blank')
      end
      it '商品の状態ないと出品できない' do
        @product.condition_id = 1
        @product.valid?
        expect(@product.errors.full_messages).to include('Product condition cannot be blank')
      end
      it '配送料の負担ないと出品できない' do
        @product.shipping_cost_id = 1
        @product.valid?
        expect(@product.errors.full_messages).to include('Shipping cost responsibility cannot be blank')
      end
      it '発送元の地域がないと出品できない' do
        @product.prefecture_id = 1
        @product.valid?
        expect(@product.errors.full_messages).to include('Prefecture cannot be blank')
      end
      it '発送までの日数ないと出品できない' do
        @product.shipping_date_id = 1
        @product.valid?
        expect(@product.errors.full_messages).to include('Shipping date cannot be blank')
      end
      it '価格の情報がないと出品できない' do
        @product.price = ''
        @product.valid?
        expect(@product.errors.full_messages).to include('Price information cannot be blank')
      end
      it '価格が¥300未満のとき出品できない' do
        @product.price = '300'
        @product.valid?
        expect(@product.errors.full_messages).to include('Price must be at least ¥300 to list the item')
      end
      it '価格が¥10,000,000以上のとき出品できない' do
        @product.price = '10,000,000'
        @product.valid?
        expect(@product.errors.full_messages).to include('Price must be less than ¥10,000,000 to list the product')
      end
      it '全角数値を含む価格では出品できない' do
        @product.price = 'price全角数値'
        @product.valid?
        expect(@product.errors.full_messages).to include('Price must be entered in half-width numbers')
      end
    end
  end
end
