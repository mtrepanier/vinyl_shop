json.extract! @concert, :id, :show_date, :formated_show_date, :formated_show_time, :venue, :price, :artists, :artists_names, :created_at, :updated_at
json.formated_price number_to_currency @concert.price
