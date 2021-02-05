require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品' do
    context '商品出品ができる時' do
      it '全項目入力すれば登録できること' do
        expect(@item).to be_valid
      end

      it '価格が300円なら登録できること' do
        @item.price = 300
        expect(@item).to be_valid
      end

      it '価格が9999999円なら登録できること' do
        @item.price = 9_999_999
        expect(@item).to be_valid
      end
    end

    context '商品出品ができない時' do
      it '出品画像が空では登録できないこと' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end

      it '商品名が空では登録できないこと' do
        @item.name = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end

      it 'カテゴリーが空では登録できないこと' do
        @item.category_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end

      it 'カテゴリーが初期値"---"では登録できないこと' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Category Select')
      end

      it '商品の状態が空では登録できないこと' do
        @item.condition_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Condition can't be blank")
      end

      it '商品の状態が初期値"---"では登録できないこと' do
        @item.condition_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Condition Select')
      end

      it '配送料の負担が空では登録できないこと' do
        @item.shipping_fee_person_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping fee person can't be blank")
      end

      it '配送料の負担が初期値"---"では登録できないこと' do
        @item.shipping_fee_person_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Shipping fee person Select')
      end

      it '発送元の地域が空では登録できないこと' do
        @item.ship_from_region_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Ship from region can't be blank")
      end

      it '発送元の地域が初期値"---"では登録できないこと' do
        @item.ship_from_region_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Ship from region Select')
      end

      it '発送までの日数が空では登録できないこと' do
        @item.delivery_day_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Delivery day can't be blank")
      end

      it '発送までの日数が初期値"---"では登録できないこと' do
        @item.delivery_day_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Delivery day Select')
      end

      it '価格が空では登録できないこと' do
        @item.price = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end

      it '価格が299円以下だと登録できないこと' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include('Price Out of setting range')
      end

      it '価格が10000000円以上だと登録できないこと' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include('Price Out of setting range')
      end

      it '価格が全角数値では登録できないこと' do
        @item.price = '５００'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price Half-width number')
      end

      it '価格が半角英数混合では登録できないこと' do
        @item.price = 'a555'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price Half-width number')
      end

      it '価格が半角英数では登録できないこと' do
        @item.price = 'aaaa'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price Half-width number')
      end
    end
  end
end
