class CreateArtistsConcerts < ActiveRecord::Migration
  def change
    create_table :artists_concerts , id: false do |t|
      t.belongs_to :artist, index: true
      t.belongs_to :concert, index: true
    end
  end
end
