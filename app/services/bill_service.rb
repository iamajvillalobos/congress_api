class BillService < BaseService
  MAX_LIMIT = 250

  def fetch_bills(params = {})
    response = fetch("bill", params)
    save_bills(response["bills"])
  end

  def fetch_recent_bills(limit = 20, offset = 0)
    fetch_bills(limit: limit, offset: offset, sort: "updateDate+desc")
  end

  def fetch_bills_by_date_range(from_date, to_date, params = {})
    set_date_range(from_date, to_date)
    fetch_all_bills(params)
  end

  def fetch_all_bills(params)
    all_bills = []
    total_count = nil
    current_params = params.merge(limit: MAX_LIMIT)

    loop do
      response = fetch("bill", current_params)
      bills = save_bills(response["bills"])
      all_bills.concat(bills)

      total_count ||= response["pagination"]["count"].to_i

      break if all_bills.size >= total_count || response["pagination"]["next"].nil?

      next_uri = URI(response["pagination"]["next"])
      current_params = CGI.parse(next_uri.query).transform_values(&:first)
    end

    all_bills
  end

  def save_bills(bills)
    return [] if bills.nil?

    bills.each do |bill_data|
      bill = Bill.find_or_initialize_by(
        congress: bill_data["congress"],
        number: bill_data["number"],
        bill_type: bill_data["type"],
      )

      bill.update!(
        title: bill_data["title"],
        origin_chamber: bill_data["originChamber"],
        origin_chamber_code: bill_data["originChamberCode"],
        update_date: Date.parse(bill_data["updateDate"]),
        update_date_including_text: DateTime.parse(bill_data["updateDateIncludingText"]),
        url: bill_data["url"],
        latest_action: bill_data["latestAction"]
      )

      bill
    end
  end
end
