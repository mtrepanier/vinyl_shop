class Artist < ActiveRecord::Base
	has_and_belongs_to_many :concerts

	before_create :fetch_from_spotify, unless: :spotify_artist_id?

	validates :name, presence: true

	protected
		def fetch_from_spotify
			spotify_client = Spotify::Client.new
			spotify_artists = spotify_client.search(:artist, format_name_for_spotify_search)

			if spotify_artists && spotify_artists['artists'] && spotify_artists['artists']['items'].length > 0
				spotify_artist = spotify_artists['artists']['items'][0]
				spotify_artists['artists']['items'].each do |artist|
					if artist['name'].downcase == self.name.downcase
						spotify_artist = artist
						break 
					end
				end
				self.spotify_artist_id = spotify_artist['id'];
				self.artist_thumbnail_url = spotify_artist['images'][0]['url'] if spotify_artist['images'].length > 0
			end
		end

		def format_name_for_spotify_search
			formated_name = self.name.downcase
			formated_name = formated_name.gsub " & ", " "
			formated_name = formated_name.gsub " (live)", ""
		end
end
