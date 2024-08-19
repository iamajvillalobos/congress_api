require "csv"

namespace :export do
  task bill: :environment do
    export_dir = Rails.root.join("export")
    export_dir.mkdir unless export_dir.exist?

    csv_file = export_dir.join("bills.csv")
    CSV.open(csv_file, "w") do |csv|
      csv << Bill.column_names
      Bill.find_each do |bill|
        csv << bill.attributes.values_at(*Bill.column_names)
      end
    end
  end
end
