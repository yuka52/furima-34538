require 'rails_helper'

RSpec.describe OrderDestination, type: :model do
  describe '配送先住所の保存' do
    before do
      user = FactoryBot.create(:user)
      item = FactoryBot.create(:item)
      @order_destination = FactoryBot.build(:order_destination, user_id: user.id, item_id: item.id)
      sleep 0.1
    end

    context '配送先住所が保存できる場合' do
      it 'すべての値が正しく入力されていれば配送先の情報が保存できること' do
        expect(@order_destination).to be_valid
      end

      it 'buildingは空でも保存できること' do
        @order_destination.building = ''
        expect(@order_destination).to be_valid
      end
    end

    context '配送先住所が保存できない場合' do
      it 'postal_codeが空だと保存できないこと' do
        @order_destination.postal_code = ''
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("Postal code can't be blank")
      end

      it 'postal_codeが半角のハイフンを含んだ正しい形式でないと保存できないこと' do
        @order_destination.postal_code = '1234567'
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("Postal code Input correctly")
      end

      it 'postal_codeが全角だと保存できないこと' do
        @order_destination.postal_code = '１２３-４５６７'
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("Postal code Input correctly")
      end

      it 'prefectureを選択していないと保存できないこと' do
        @order_destination.prefecture_id = ''
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("Prefecture can't be blank")
      end

      it 'prefectureは１を選択すると保存できないこと' do
        @order_destination.prefecture_id = 1
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("Prefecture must be other than 1")
      end

      it 'municipalityが空だと保存できないこと' do
        @order_destination.municipality = ''
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("Municipality can't be blank")
      end

      it 'addressが空だと保存できないこと' do
        @order_destination.address = ''
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("Address can't be blank")
      end
      
      it 'phone_numberが空だと保存できないこと' do
        @order_destination.phone_number = ''
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("Phone number can't be blank")
      end

      it 'phone_numberが全角数字だと保存できないこと' do
        @order_destination.phone_number = '０９０１２３４５６７８'
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("Phone number Input only half-width number")
      end

      it 'phone_numberが英数字混合だと保存できないこと' do
        @order_destination.phone_number = '090abcdefgh'
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("Phone number Input only half-width number")
      end

      it 'phone_numberが12桁以上だと保存できないこと' do
        @order_destination.phone_number = '090123456789'
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("Phone number Input only half-width number")
      end

      it "tokenが空だと保存できないこと" do
        @order_destination.token = nil
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("Token can't be blank")
      end

      it "user_idが空だと購入できないこと" do
        @order_destination.user_id = nil
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("User can't be blank")
      end

      it "item_idが空だと購入できないこと" do
        @order_destination.item_id = nil
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("Item can't be blank")
      end
    end 
  end
end
