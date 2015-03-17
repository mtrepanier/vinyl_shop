json.array!(@artists) do |artist|
  json.extract! artist, :id, :name, :spotify_artist_id, :artist_thumbnail_url, :concerts
  json.url api_artist_url(artist, format: :json)
end
