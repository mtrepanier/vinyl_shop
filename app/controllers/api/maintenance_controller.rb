require 'open-uri'

class Api::MaintenanceController < ApplicationController
  def refresh_from_cheapthrills
  	concerts_tr = get_concert_tr_from_cheapthrills
  	concerts = []
  	concerts_tr.each do |concert_tr|
  		venue = get_venue_from_concert_tr(concert_tr)
  		show_date = get_show_date_from_concert_tr(concert_tr)
  		artists = get_artists_from_concert_tr(concert_tr)
  		price = get_price_from_concert_tr(concert_tr)
  		is_sold_out = get_if_sold_out_from_concert_tr(concert_tr)

  		concert = Concert.where(venue_id: venue.id, show_date: show_date, is_generated: true).take
  		if concert
  			concert.artists = artists
  			concert.price = price
  			concert.is_generated = true
  			concert.is_sold_out = is_sold_out
  		else
	  		concert = Concert.new do |c|
		  		c.artists = artists
		  		c.venue = venue
		  		c.show_date = show_date
		  		c.price = price
		  		c.is_generated = true
		  		c.is_sold_out = is_sold_out
		  	end
		end
	  	concert.save
  		concerts.push concert
  	end

  	Concert.delete_all(["id not in (?) AND is_generated = ?", concerts.collect{|c| c.id},true])
  end

  private
  def get_concert_tr_from_cheapthrills
  	news_tmp_file = open('http://cheapthrills.ca/news.html')
	doc = Nokogiri::HTML(news_tmp_file)
	
	concerts = doc.css("table")[1].css("tr")
	concerts.shift
	concerts
  end

  def get_if_sold_out_from_concert_tr(concert_tr)
  	sold_out = clean_string(concert_tr.css("td")[0].css("font").text)
  	return true unless sold_out.blank?
  end

  def get_price_from_concert_tr(concert_tr)
  	price = clean_string(concert_tr.css("td")[5].css("font").text)
  	price = price.gsub "$", ""
  	price
  end

  def get_show_date_from_concert_tr(concert_tr)
  	show_date_string = "#{clean_string(concert_tr.css("td")[2].css("font").text)} #{clean_string(concert_tr.css("td")[3].css("font").text)}"
  	DateTime.parse show_date_string
  end

  def get_venue_from_concert_tr(concert_tr)
  	venue_name = clean_string(concert_tr.css("td")[4].css("font").text)

	venue = Venue.find_by name: venue_name
	if venue
		return venue
	else
		venue = Venue.new do |v|
			v.name = venue_name
		end
		venue.save
		return venue
	end
  end

  def get_artists_from_concert_tr(concert_tr)
  	artists = []
  	names = concert_tr.css("td")[1].css("font").text

  	if names.index('+')
  		names.split(" + ").each do |name|
	  		artists.push find_or_create_artist(name) unless name.nil?
		end
  	elsif names.index('/')
  		names.split("/").each do |name|
	  		artists.push find_or_create_artist(name) unless name.nil?
		end
  	else
  		artists.push find_or_create_artist(names) unless names.nil?
  	end
  	artists
  end

  def find_or_create_artist(name)
  	name = clean_string(name)

	artist = Artist.find_by name: name
	if artist
		return artist
	else
		artist = Artist.new do |a|
			a.name = name
		end
		artist.save
		return artist
	end
  end

  def clean_string(value)
  	value = value.gsub "\r",""
	value = value.gsub "\n",""
	value 
  end
end
