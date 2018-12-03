class Customer < ApplicationRecord
  has_many :invoices
  has_many :transactions, through: :invoices

  def self.favorite_customer(merchant_id)
    select('customers.*, count(transactions.id) as total')
    .joins(:invoices, invoices: :transactions)
    .where(transactions: {result: 'success'})
    .group(:id)
    .order('total desc')
    .where("invoices.merchant_id = #{merchant_id}")
    .limit(1)
    .first
  end

  def self.with_pending_invoices(merchant_id)
    Customer.where(id: Invoice.where(merchant_id: merchant_id)
                      .left_outer_joins(:transactions)
                      .group(:id)
                      .pluck('invoices.customer_id')
          )
  end
end
