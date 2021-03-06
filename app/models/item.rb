class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def self.most_revenue(quantity)
    select('items.*, sum(invoice_items.quantity * invoice_items.unit_price) as revenue')
    .joins(:invoice_items, :invoices)
    .group(:id)
    .order('revenue desc')
    .limit(quantity)
  end

  def self.most_items(quantity)
    select('items.*, sum(invoice_items.quantity) as total_sold')
    .joins(:invoice_items)
    .group(:id)
    .order('total_sold desc')
    .limit(quantity)
  end

end
