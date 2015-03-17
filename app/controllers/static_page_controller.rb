class StaticPageController < ApplicationController
	def homepage
		@concerts = Concert.all
	end
end
