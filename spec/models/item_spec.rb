require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品情報の出品' do
    context '商品が出品できる場合' do
      it '必要な情報が適切に存在すれば出品できること' do
        expect(@item).to be_valid
      end
    end

    context '商品が出品できない場合' do
      it '商品画像が存在しなければ出品できないこと' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end

      it '商品名が存在しなければ出品できないこと' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end

      it '商品の説明が存在しなければ出品できないこと' do
        @item.description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Description can't be blank")
      end

      it 'カテゴリーの情報が存在しなければ出品できないこと' do
        @item.category_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('Category Select')
      end

      it '商品の状態についての情報が存在しなければ出品できないこと' do
        @item.condition_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('Condition Select')
      end

      it '配送料の負担についての情報が存在しなければ出品できないこと' do
        @item.delivery_fee_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('Delivery fee Select')
      end

      it '発送元の地域についての情報が存在しなければ出品できないこと' do
        @item.prefecture_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('Prefecture Select')
      end

      it '発送までの日数についての情報が存在しなければ出品できないこと' do
        @item.days_to_ship_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('Days to ship Select')
      end

      it '販売価格が300円未満だと出品できないこと' do
        @item.price = '299'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price Out of setting range')
      end

      it '販売価格が9,999,999円より高いと出品できないこと' do
        @item.price = '10000000'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price Out of setting range')
      end

      it '販売価格が全角だと出品できないこと' do
        @item.price = '３００'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price Half-width number')
      end
    end
  end
end
