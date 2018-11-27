namespace :import do
  task merchants: :environment do
    filename = File.join Rails.root, '../sales_engine/data/merchants.csv'
    counter = 0
    CSV.foreach(filename, headers: true) do |row|
      merchant = Merchant.create(id: row['id'],
                                name: row['name'],
                                created_at: row['created_at'],
                                updated_at: row['updated_at'])
      counter += 1 if merchant.persisted?
    end

    puts "Imported #{counter} merchants"
  end
end
