class Product < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user
  belongs_to :category
  belongs_to :condition
  belongs_to :prefecture
  belongs_to :shipping_cost
  belongs_to :shipping_date
  has_one_attached :image

  validates :image, :name, :description, presence: true
  validates :category_id, :condition_id, :prefecture_id, :shipping_cost_id, :shipping_date_id,
            numericality: { other_than: 1, message: "can't be blank" }
  validates :price, presence: true
  validates :price, numericality: true
end
