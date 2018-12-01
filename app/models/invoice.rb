class Invoice < ApplicationRecord
  belongs_to :customer
  belongs_to :merchant
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :transactions

  def self.best_day(item_id)
    select('invoices.created_at, sum(invoice_item.quantity) as units_sold')
    .joins(:invoice_items)
    .group(:id)
    .order('units_sold desc')
    .order(created_at: :desc)
    .where("invoice_items.item_id = #{item_id}")
    .limit(1)
  end
end
