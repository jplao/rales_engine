namespace :import do

  desc "Import all CSV files"
  task all: :environment do
    Rake::Task["import:merchants"].execute
    Rake::Task["import:customers"].execute
    Rake::Task["import:invoices"].execute
    Rake::Task["import:items"].execute
    Rake::Task["import:invoice_items"].execute
    Rake::Task["import:transactions"].execute
  end

  task merchants: :environment do
    counter = 0
    CSV.foreach('db/data/merchants.csv', headers: true, header_converters: :symbol) do |row|
      merchant = Merchant.create(row.to_hash)
      counter += 1 if merchant.persisted?
    end

    puts "Imported #{counter} merchants"
  end

  task items: :environment do
    counter = 0
    CSV.foreach('db/data/items.csv', headers: true, header_converters: :symbol) do |row|
      item = Item.create(row.to_hash)
      counter += 1 if item.persisted?
    end

    puts "Imported #{counter} items"
  end

  task customers: :environment do
    counter = 0
    CSV.foreach('db/data/customers.csv', headers: true, header_converters: :symbol) do |row|
      customer = Customer.create(row.to_hash)
      counter += 1 if customer.persisted?
    end

    puts "Imported #{counter} customers"
  end

  task invoices: :environment do
    counter = 0
    CSV.foreach('db/data/invoices.csv', headers: true, header_converters: :symbol) do |row|
      invoice = Invoice.create(row.to_hash)
      counter += 1 if invoice.persisted?
    end

    puts "Imported #{counter} invoices"
  end

  task invoice_items: :environment do
    counter = 0
    CSV.foreach('db/data/invoice_items.csv', headers: true, header_converters: :symbol) do |row|
      invoice_item = InvoiceItem.create(row.to_hash)
      counter += 1 if invoice_item.persisted?
    end

    puts "Imported #{counter} invoice items"
  end

  task transactions: :environment do
    counter = 0
    CSV.foreach('db/data/transactions.csv', headers: true, header_converters: :symbol) do |row|
      transaction = Transaction.create(row.to_hash)
      counter += 1 if transaction.persisted?
    end

    puts "Imported #{counter} transactions"
  end
end
