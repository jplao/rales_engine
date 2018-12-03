class Invoice < ApplicationRecord
  belongs_to :customer
  belongs_to :merchant
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :transactions

  def self.best_day(item_id)
    select('invoices.created_at, sum(invoice_items.quantity) as units_sold')
    .joins(:invoice_items)
    .group(:id)
    .order('units_sold desc')
    .order(created_at: :desc)
    .where("invoice_items.item_id = #{item_id}")
    .limit(1)
    .first
  end

  def self.total_revenue_by_date(date)
    select('sum(invoice_items.quantity * invoice_items.unit_price) as total_revenue')
    .joins(:invoice_items, :transactions)
    .where(transactions: {result:'success'})
    .where(created_at: date)
  end

  def self.merchant_revenue_by_date(date, merchant)
    select('sum(invoice_items.quantity * invoice_items.unit_price) as revenue')
    .joins(:invoice_items, :transactions)
    .where(transactions: {result:'success'})
    .where(created_at: date)
    .where(merchant_id: merchant)
  end
end
