class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :Category
  belongs_to :Condition
  belongs_to :delivery_fee
  belongs_to :Prefecture
  belongs_to :day_to_ship
  
  with_options presense: true do
   validates :name  
   validates :description

   with_options numericality: {oter_than: 1 } do 
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