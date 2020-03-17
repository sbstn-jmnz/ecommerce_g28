class Billing < ApplicationRecord
  belongs_to :user

  def self.init_payment(items,total)
    PayPal::SDK::REST::Payment.new({
      intent: "sale",
      payer: { payment_method: "paypal" },
      redirect_urls: {
              return_url: "http://localhost:3000/billings/execute",
              cancel_url: "http://localhost:3000/" },
      transactions: [{
        item_list: { items: items },
        amount: { total: total.to_s, currency: "USD" },
        description: "Compra desde E-commerce Rails." }]
      })
  end

  def self.execute_payment(current_user, payment_id, client_id)
    paypal_payment = PayPal::SDK::REST::Payment.find(payment_id)
    return false unless  paypal_payment.execute(payer_id: client_id)

    amount = paypal_payment.transactions.first.amount.total
    billing = Billing.create(
      user: current_user,
      code: payment_id,
      payment_method: 'paypal',
      amount: amount,
      currency: 'USD'
    )
    if billing.persisted?
    current_user.orders.cart.update_all(payed: true, billing_id: billing.id)
      return true
    else
      return false
    end
  end
end
