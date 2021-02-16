require 'rails_helper'

RSpec.describe OrderInformation, type: :model do
  before do
    @order_information = FactoryBot.build(:order_information)
  end

  describe '商品購入' do
    context '商品購入ができる時' do
      it '全項目入力すれば購入できること' do
        expect(@order_information).to be_valid
      end

      it '建物名は空でも購入できること' do
        @order_information.building = ""
        expect(@order_information).to be_valid
      end
    end

    context '商品購入ができない時' do
      it '郵便番号が空なら購入できないこと' do
        @order_information.post_code = nil
        @order_information.valid?
        expect(@order_information.errors.full_messages).to include("Post code can't be blank")
      end
      
      it '郵便番号がハイフンなしなら購入できないこと' do
        @order_information.post_code = "1234567"
        @order_information.valid?
        expect(@order_information.errors.full_messages).to include("Post code Input correctly")
      end

      it '郵便番号が6桁なら購入できないこと' do
        @order_information.post_code = "123-456"
        @order_information.valid?
        expect(@order_information.errors.full_messages).to include("Post code Input correctly")
      end

      it '都道府県が空なら購入できないこと' do
        @order_information.region_id = nil
        @order_information.valid?
        expect(@order_information.errors.full_messages).to include("Region can't be blank")
      end

      it '都道府県が初期値"---"なら購入できないこと' do
        @order_information.region_id = "1"
        @order_information.valid?
        expect(@order_information.errors.full_messages).to include("Region Select")
      end

      it '市区町村が空なら購入できないこと' do
        @order_information.city = nil
        @order_information.valid?
        expect(@order_information.errors.full_messages).to include("City can't be blank")
      end

      it '番地が空なら購入できないこと' do
        @order_information.address = nil
        @order_information.valid?
        expect(@order_information.errors.full_messages).to include("Address can't be blank")
      end

      it '電話番号が空なら購入できないこと' do
        @order_information.phone_number = nil
        @order_information.valid?
        expect(@order_information.errors.full_messages).to include("Phone number can't be blank")
      end

      it '電話番号が12桁なら購入できないこと' do
        @order_information.phone_number = "090123456789"
        @order_information.valid?
        expect(@order_information.errors.full_messages).to include("Phone number Input only number")
      end

      it '電話番号が英字なら購入できないこと' do
        @order_information.phone_number = "aaaaaa"
        @order_information.valid?
        expect(@order_information.errors.full_messages).to include("Phone number Input only number")
      end

      it 'tokenが空なら購入できないこと' do
        @order_information.token = nil
        @order_information.valid?
        expect(@order_information.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end
