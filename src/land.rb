$LOAD_PATH << '.'
require "sdl"

class Land
	def initialize(window)
		@window = window
		@images = [SDL::Surface.load("../assets/land_0.png"), SDL::Surface.load("../assets/land_1.png")]
		@speed = 0.25
		@x = [0, 0]
		@sprites = [0, 1]
		@y = (@window.h - @images[0].h) - 10
	end

	def animation
		@x[0] -= @speed
		SDL::Surface.blit(@images[sprites[0]], 0, 0, @images[0].w, @images[0].h, @window, @x[0], @y)
		if @x[0] <= 0
			@x[1] = @x[0] + @images[0].w 
		else
			@x[1] -= @speed
		end

		SDL::Surface.blit(@images[sprites[1]], 0, 0, @images[0].w, @images[0].h, @window, @x[1], @y)
		@x[0] = @x[1] + @images[1].w if @x[1] <= 0
	end

	def draw
		animation
	end
end