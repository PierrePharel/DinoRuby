$LOAD_PATH << '.'
require "sdl"
require "land.rb"

class Window 
	def initialize(width, height)
		@width = width 
		@height = height
		# window settings
		@window = SDL::Screen.open(@width, @height, 32, SDL::SWSURFACE)
		SDL::WM.set_caption("Dino Ruby", "")
		# objects for drawing
		@background = SDL::Surface.new(SDL::SWSURFACE, @width, @height, 32, 0, 0, 0, 0)
		@land = Land.new(@window)
	end

	def background
		@background.fill_rect(0, 0, @width, @height, [255, 255, 255])
		SDL::Surface.blit(@background, 0, 0, @width, @height, @window, 0, 0)
	end

	def update
		@window.update_rect(0, 0, @width, @height)
	end

	def draw
		@land.draw
	end
end