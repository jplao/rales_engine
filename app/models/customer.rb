class Customer < ApplicationRecord
  has_many :invoices

  def self.favorite_customer(merchant_id)
    select('customers.*, count(transactions.id) as total')
    .joins(:invoices, invoices: :transactions)
    .where(transactions: {result: 'success'})
    .group(:id)
    .order('total desc')
    .where("invoices.merchant_id = #{merchant_id}")
    .limit(1)
  end

  def self.by_invoice(invoice_id)
    joins(:invoices)
    .where("invoices.id = #{invoice_id}")
  end
end
