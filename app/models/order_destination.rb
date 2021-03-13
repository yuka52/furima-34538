class OrderDestination
  include ActiveModel::Model
  attr_accessor   :user_id, :item_id, :postal_code, :prefecture_id, :municipality, :address, :building, :phone_number, :order_id, :token
  
  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :postal_code, format: {with: /\A\d{3}[-]\d{4}\z/, message: "Input correctly"}
    validates :prefecture_id, numericality: {other_than: 1}
    validates :municipality
    validates :address
    validates :phone_number, format: {with: /\A\d{10,11}\z/, message: "Input only half-width number"}
    validates :token
  end

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    Destination.create(postal_code: postal_code, prefecture_id: prefecture_id, municipality: municipality, address: address, building: building, phone_number: phone_number, order_id: order.id)
  end
end
