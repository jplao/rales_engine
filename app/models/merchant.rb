class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices

  def self.total_revenue(number_of_results = 1)
    select('merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) as revenue')
    .joins(:invoices, invoices: [:invoice_items, :transactions])
    .where(transactions: {result: 'success'})
    .group(:id)
    .order('revenue desc')
    .limit(number_of_results)
  end

  def self.revenue(id)
    select('merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) as revenue')
    .joins(:invoices, invoices: [:invoice_items, :transactions])
    .where(transactions: {result: 'success'})
    .group(:id)
    .where(id: id)
  end
end
