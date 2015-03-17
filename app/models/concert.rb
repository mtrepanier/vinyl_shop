class Concert < ActiveRecord::Base
	has_and_belongs_to_many :artists
	belongs_to :venue

	validates :venue, :artists, :show_date, :price, presence: true

	def artists_names
		self.artists.collect{|a| a.name}.join(", ")
	end

	def formated_show_date
		"#{self.show_date.day}-#{Date::MONTHNAMES[self.show_date.month]}-#{self.show_date.year}"
	end

	def formated_show_time
		self.show_date.strftime("%I:%M%p")
	end
end
