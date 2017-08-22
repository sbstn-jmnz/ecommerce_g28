class OrdersController < ApplicationController
  before_action :authenticate_user!

  def create
    p = Product.find(params[:product_id])
    o = Order.new(user: current_user, product: p)
    if o.save
      redirect_to products_path, notice: "La orden de compra ha sido agregada"
    else
      redirect_to products_path, alert: "La orden de compra ha podido ser agregada"
    end
  end

  def index
    @orders = current_user.orders.where(payed: false)
  end
end
