## Setup
```
bin/setup
touch .env
echo "CONGRESS_API_KEY=" >> .env
```

## Fetch Bills
```
BillService.new.fetch_recent_bills # only fetch recent 20

from_date = Date.parse("Aug 17, 2024")
to_date = Date.parse("Aug 19, 2024")
BillService.new.fetch_bills_by_date_range(from_date, to_date)
```

## Export Bills to CSV
```
rake export:bill
```