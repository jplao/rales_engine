require 'rails_helper'

describe Item, type: :model do
  describe 'Relationships' do
    it {should belong_to :merchant}
    it {should have_many :invoice_items}
    it {should have_many(:invoices).through(:invoice_items)}
  end
end
