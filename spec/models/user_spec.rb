require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザ新規登録' do
    context 'ユーザが新規登録ができる時' do
      it '全項目入力し、ユーザ本名は漢字、フリガナは全角カタカナで入力すると登録できること' do
        expect(@user).to be_valid
      end
    end

    context 'ユーザが新規登録ができない時' do
      it 'nicknameが空では登録できないこと' do
        @user.nickname = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end

      it 'emailが空では登録できないこと' do
        @user.email = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end

      it 'emailに@が含まれていないと登録できないこと' do
        @user.email = 'abc.com'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end

      it 'emailが重複していると登録できないこと' do
        @user2 = FactoryBot.build(:user, email: @user.email)
        @user2.save
        @user.valid?
        expect(@user.errors.full_messages).to include('Email has already been taken')
      end

      it 'passwordが空では登録できないこと' do
        @user.password = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end

      it 'passwordが5文字以下であれば登録できないこと' do
        @user.password = '1234a'
        @user.password_confirmation = '1234a'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end

      it 'passwordが全角英数混合では登録できないこと' do
        @user.password = 'A１2345'
        @user.password_confirmation = 'A１2345'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password Include both letters and numbers')
      end

      it 'passwordが英字のみであれば登録できないこと' do
        @user.password = 'aaaaaa'
        @user.password_confirmation = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password Include both letters and numbers')
      end

      it 'passwordが数字のみであれば登録できないこと' do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password Include both letters and numbers')
      end

      it 'passwordとpassword_confirmationが不一致では登録できないこと' do
        @user.password = '99999a'
        @user.password_confirmation = '99999b'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it '名字（漢字）が空では登録できないこと' do
        @user.last_name_kanji = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kanji can't be blank")
      end

      it '名字(漢字)が半角カタカナでは登録できないこと' do
        @user.last_name_kanji = 'ｱｱｱ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kanji Full-width characters')
      end

      it '名前（漢字）が空では登録できないこと' do
        @user.first_name_kanji = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kanji can't be blank")
      end

      it '名前(漢字)が半角カタカナでは登録できないこと' do
        @user.first_name_kanji = 'ｱｱｱ'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kanji Full-width characters')
      end

      it '名字(フリガナ)がひらがなでは登録できないこと' do
        @user.last_name_kana = 'あああ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kana Full-width katakana characters')
      end

      it '名字(フリガナ)が漢字では登録できないこと' do
        @user.last_name_kana = '性'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kana Full-width katakana characters')
      end

      it '名字(フリガナ)がひらがなでは登録できないこと' do
        @user.last_name_kana = 'あああ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kana Full-width katakana characters')
      end

      it '名字(フリガナ)が半角カタカナでは登録できないこと' do
        @user.last_name_kana = 'ｱｱｱ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kana Full-width katakana characters')
      end

      it '名前(フリガナ)が空では登録できないこと' do
        @user.first_name_kana = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank")
      end

      it '名前(フリガナ)が漢字では登録できないこと' do
        @user.first_name_kana = '性'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana Full-width katakana characters')
      end
      it '名前(フリガナ)がひらがなでは登録できないこと' do
        @user.first_name_kana = 'あああ'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana Full-width katakana characters')
      end

      it '名前(フリガナ)が半角カタカナでは登録できないこと' do
        @user.first_name_kana = 'ｱｱｱ'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana Full-width katakana characters')
      end

      it '生年月日が空では登録できないこと' do
        @user.birth_date = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Birth date can't be blank")
      end
    end
  end
end
