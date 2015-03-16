json.array!(@artists) do |artist|
  json.extract! artist, :id, :name, :spotify_artist_id, :artist_thumbnail_url
  json.url artist_url([:api, artist], format: :json)
end
