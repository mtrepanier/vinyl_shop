json.array!(@concerts) do |concert|
  json.extract! concert, :id, :show_date, :formated_show_time, :formated_show_date, :venue, :price, :artists_names
  json.formated_price number_to_currency concert.price
  json.artists concert.artists do |artist|
  	json.(artist , :id, :name, :spotify_artist_id, :artist_thumbnail_url)
  	if artist.spotify_artist_id.blank?
  		json.embed_spotify ""
  	else  
  		json.embed_spotify "https://embed.spotify.com/?uri=spotify%3Aartist%3A#{artist.spotify_artist_id}"
  	end
  end
  json.url api_concert_url(concert, format: :json)
end
