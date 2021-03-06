class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :delivery_fee
  belongs_to :Prefecture
  belongs_to :day_to_ship
  has_one_attached :image
  
  with_options presence: true do
   validates :name  
   validates :description
   validates :image

   with_options numericality: {oter_than: 1 } do 
      validates :category_id
      validates :condition_id 
      validates :delivery_fee_id 
      validates :prefecture_id  
      validates :days_to_ship_id
   end
   
   with_options numericality: { only_integer: true,
     greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999
     },
     format: {with: /\A[0-9]+\z/} do
      validates :price
    end
  end 
end
