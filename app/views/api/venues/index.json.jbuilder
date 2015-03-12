json.array!(@venues) do |venue|
  json.extract! venue, :id, :name
  json.url api_venue_url(venue, format: :json)
end
