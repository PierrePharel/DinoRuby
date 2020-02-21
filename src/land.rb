$LOAD_PATH << '.'
require "sdl"

class Land
	def initialize(window)
		@window = window
		@sprite = [SDL::Surface.load("../assets/land_0.png"), SDL::Surface.load("../assets/land_1.png")]
		@speed = 0.25
		@x = [0, 0]
		@frames = [0, 1]
		@y = (@window.h - @sprite[0].h) - 10
	end

	def animation
		@x[0] -= @speed
		SDL::Surface.blit(@sprite[@frames[0]], 0, 0, @sprite[0].w, @sprite[0].h, @window, @x[0], @y)
		if @x[0] <= 0
			@x[1] = @x[0] + @sprite[0].w 
		else
			@x[1] -= @speed
		end

		SDL::Surface.blit(@sprite[@frames[1]], 0, 0, @sprite[0].w, @sprite[0].h, @window, @x[1], @y)
		if @x[1] <= 0
			@frames[0] = rand(0..1) if @x[1] == 0
			@x[0] = @x[1] + @sprite[1].w 
		end
	end

	def draw
		animation
	end
end