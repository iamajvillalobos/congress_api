class BaseService
  include HTTParty
  base_uri "https://api.congress.gov/v3"

  def initialize(from_date = nil, to_date = nil)
    @options = {
      query: {
        api_key: ENV["CONGRESS_API_KEY"],
        format: "json"
      }
    }

    set_date_range(from_date, to_date) if from_date && to_date
  end

  def fetch(endpoint, params = {})
    @options[:query].merge!(params)
    response = self.class.get("/#{endpoint}", @options)

    if response.success?
      response.parsed_response
    else
      raise "API request failed: #{response.code} #{response.message}"
    end
  end

  private

  def set_date_range(from_date, to_date)
    @options[:query].merge!(
      fromDateTime: format_date(from_date),
      toDateTime: format_date(to_date)
    )
  end

  def format_date(date)
    date.strftime("%Y-%m-%dT%H:%M:%SZ")
  end
end
