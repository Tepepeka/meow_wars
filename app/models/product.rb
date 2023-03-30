class Product < ApplicationRecord

  has_many :orderables
  has_many :carts, through: :orderables

  has_many :order_products
  has_many :carts, through: :order_products

  has_many :comments

  scope :ordered, -> { order(id: :desc) }

  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  
  broadcasts_to ->(product) { "products" }, inserts_by: :prepend
end