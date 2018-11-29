class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items

  def self.most_revenue(quantity)
    select('items.*, sum(invoice_items.quantity * invoice_items.unit_price) as revenue')
    .joins(:invoice_items, invoice_items: :invoices)
    .group(:id).order('revenue desc')
    .order('revenue desc')
    .limit(quantity)
  end
end
