class PurchaseAddress
  include ActiveModel::Model
  attr_accessor :post_code, :prefecture_id, :municipality, :street_address, :building_name, :phone_number, :purchase, :product_id,
                :user_id, :token

  with_options presence: true do
    validates :municipality
    validates :street_address
    validates :phone_number, format: { with: /\A\d{10,11}\z/, message: 'is invalid' }
    validates :product_id
    validates :user_id
    validates :token
    validates :post_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: '郵便番号を入力してください' }
    validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }
  end

  def save
    purchase = Purchase.create(user_id: user_id, product_id: product_id)

    Address.create(post_code: post_code, prefecture_id: prefecture_id, municipality: municipality, street_address: street_address,
                   building_name: building_name, phone_number: phone_number, purchase_id: purchase.id)
  end
end
