class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices

  def self.total_revenue(quantity)
    select('merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) as revenue')
    .joins(:invoices, invoices: [:invoice_items, :transactions])
    .where(transactions: {result: 'success'})
    .group(:id)
    .order('revenue desc')
    .limit(quantity)
  end

  def self.revenue(id)
    select('merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) as revenue')
    .joins(:invoices, invoices: [:invoice_items, :transactions])
    .where(transactions: {result: 'success'})
    .group(:id)
    .where(id: id)
  end

  def self.most_items(quantity)
    select('merchants.*, sum(invoice_items.quantity) as total_sold')
    .joins(:invoices, invoices: [:invoice_items, :transactions])
    .where(transactions: {result: 'success'})
    .group(:id)
    .order('total_sold desc')
    .limit(quantity)
  end

  def self.favorite_merchant(customer_id)
    select('merchants.*, count(transactions.id) as total')
    .joins(:invoices, invoices: :transactions)
    .where(transactions: {result: 'success'})
    .group(:id)
    .order('total desc')
    .where("invoices.customer_id = #{customer_id}")
    .limit(1)
  end

end
