class Orderable < ApplicationRecord

  belongs_to :product
  belongs_to :cart

  validates :quantity, presence: true, numericality: { greater_than_or_equal_to: 1 }  

  def total
    product.price * quantity
  end

end