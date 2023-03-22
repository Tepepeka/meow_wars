class Cart < ApplicationRecord

  has_many :orderables, dependent: :destroy
  has_many :products, through: :orderables
  
  #validates_uniqueness_of :product_id, scope: :cart_id, message: "already added to cart"

  def total
    orderables.to_a.sum {|orderable| orderable.total}
  end

  def total_items
    orderables.sum(:quantity)
  end

end