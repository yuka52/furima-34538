require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#create' do
    before do
      @user = FactoryBot.build(:user)
    end

    describe 'ユーザー新規登録' do
      context '新規登録がうまくいくとき' do
        it 'nickname、email、password、password_confirmation、last_name、first_name、last_name_kana、first_name_kana、birthday、が存在すれば登録できること' do
          expect(@user).to be_valid
        end

        it 'passwordは6文字以上であれば登録できること' do
          @user.password = '123abc'
          @user.password_confirmation = @user.password
          expect(@user).to be_valid
        end
      end

      context '新規登録がうまくいかないとき' do
        it 'nicknameが空では登録できないこと' do
          @user.nickname = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("Nickname can't be blank")
        end

        it 'emailが空では登録できないこと' do
          @user.email = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("Email can't be blank")
        end

        it 'emailが重複していると登録できないこと' do
          @user.save
          another_user = FactoryBot.build(:user)
          another_user.email = @user.email
          another_user.valid?
          expect(another_user.errors.full_messages).to include('Email has already been taken')
        end

        it 'emailに@が含まれていなければ登録できないこと' do
          @user.email = 'test.com'
          @user.valid?
          expect(@user.errors.full_messages).to include('Email is invalid')
        end

        it 'passwordが空では登録できないこと' do
          @user.password = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("Password can't be blank")
        end

        it 'password_confirmationが空では登録できないこと' do
          @user.password_confirmation = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
        end

        it 'passwordが5文字以下では登録できないこと' do
          @user.password = '123ab'
          @user.password_confirmation = @user.password
          @user.valid?
          expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
        end

        it 'passwordとpassword_confirmationが一致していないと登録できないこと' do
          @user.password_confirmation = '123abc'
          @user.valid?
          expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
        end

        it 'passwordが数字のみでは登録できないこと' do
          @user.password = '123456'
          @user.password_confirmation = @user.password
          @user.valid?
          expect(@user.errors.full_messages).to include('Password Include both letters and numbers')
        end

        it 'passwordが英字のみでは登録できないこと' do
          @user.password = 'abcdef'
          @user.password_confirmation = @user.password
          @user.valid?
          expect(@user.errors.full_messages).to include('Password Include both letters and numbers')
        end

        it 'passwordが全角では登録できないこと' do
          @user.password = 'ＡＢＣ１２３'
          @user.password_confirmation = @user.password
          @user.valid?
          expect(@user.errors.full_messages).to include('Password Include both letters and numbers')
        end

        it 'last_nameが空では登録できないこと' do
          @user.last_name = ''
          @user.valid?
          expect(@user.errors.full_messages).to include('Last name Full-width characters')
        end

        it 'first_nameが空では登録できないこと' do
          @user.first_name = ''
          @user.valid?
          expect(@user.errors.full_messages).to include('First name Full-width characters')
        end

        it 'last_nameは全角（漢字・ひらがな・カタカナ）でなければ登録できないこと' do
          @user.last_name = 'yamada'
          @user.valid?
          expect(@user.errors.full_messages).to include('Last name Full-width characters')
        end

        it 'first_nameは全角（漢字・ひらがな・カタカナ）でなければ登録できないこと' do
          @user.first_name = 'hanako'
          @user.valid?
          expect(@user.errors.full_messages).to include('First name Full-width characters')
        end

        it 'last_name_kanaが空では登録できないこと' do
          @user.last_name_kana = ''
          @user.valid?
          expect(@user.errors.full_messages).to include('Last name kana Full-width katakana characters')
        end

        it 'first_name_kanaが空では登録できないこと' do
          @user.first_name_kana = ''
          @user.valid?
          expect(@user.errors.full_messages).to include('First name kana Full-width katakana characters')
        end

        it 'last_name_kanaはカタカナでなければ登録できないこと' do
          @user.last_name_kana = 'やまだ'
          @user.valid?
          expect(@user.errors.full_messages).to include('Last name kana Full-width katakana characters')
        end

        it 'first_name_kanaはカタカナでなければ登録できないこと' do
          @user.first_name_kana = 'はなこ'
          @user.valid?
          expect(@user.errors.full_messages).to include('First name kana Full-width katakana characters')
        end

        it 'birthdayが空では登録できないこと' do
          @user.birthday = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("Birthday can't be blank")
        end
      end
    end
  end
end
