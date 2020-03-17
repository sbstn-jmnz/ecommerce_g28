class Order < ApplicationRecord
  belongs_to :user
  belongs_to :product
  belongs_to :billing, optional: true

  scope :cart, (-> {where(payed: false)})

  def self.total
    where(nil).pluck("price * quantity").sum
  end

  def self.to_paypal_items
    where(nil).map do |order|
       item = {}
       item[:name] = order.product.name
       item[:sku] = order.id.to_s
       item[:price] = order.price.to_s
       item[:currency] = 'USD'
       item[:quantity] = order.quantity
       item
    end
  end
end
