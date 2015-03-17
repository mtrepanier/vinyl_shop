json.array!(@concerts) do |concert|
  json.extract! concert, :id, :show_date, :venue, :price, :artists
  json.url api_concert_url(concert, format: :json)
end
