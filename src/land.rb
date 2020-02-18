$LOAD_PATH << '.'
require "sdl"
require "win_infos.rb"

class Land
	def initialize(window)
		@window = window
		@image = SDL::Surface.load("../assets/land.png")
	end

	def draw
		SDL::Surface.blit(@image, 0, 0, @image.w, @image.h, @window, 0, 0)
	end
end