class CreateArtists < ActiveRecord::Migration
  def change
    create_table :artists do |t|
      t.string :name
      t.string :spotify_artist_id
      t.string :artist_thumbnail_url

      t.timestamps null: false
    end
  end
end
