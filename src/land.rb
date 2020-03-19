#!/usr/bin/env ruby -wKU
# encoding: UTF-8

$LOAD_PATH << '.'
require "sdl"
require "common.rb"
require "animation.rb"

class Land
	
	def initialize
		@window = SDL::Screen.get
		@land = Animation.new(SDL::Surface.load("../assets/land.png"), SDL::Rect.new(0, 0, 600, 14), 5)
		@xvel = 6
		@x = [0, 0]
		@land.pos.y = (@window.h - @land.rect.h) - 10
		@cactus = Cactus.new
	end

	def move
		if @x[0] <= 0
			@x[0] -= @xvel
			@x[1] = @x[0] + @land.rect.w
		else
			@x[1] -= @xvel
		end

		if @x[1] <= 0
			@x[0] = @x[1] + @land.rect.w
		end
	end

	def animation
		SDL::Surface.blit(@land.tex, 0, 0, @land.rect.w, @land.rect.h, @window, @x[0], @land.pos.y)
		SDL::Surface.blit(@land.tex, @land.rect.w, 0, @land.rect.w, @land.rect.h, @window, @x[1], @land.pos.y)
		move
	end

	def draw
		animation
		@cactus.draw(@xvel)
	end
end

class Cactus
	attr_reader :cactus, :pos

	def initialize
		@window = SDL::Screen.get
		@small = Animation.new(SDL::Surface.load("../assets/cactus_small.png"), SDL::Rect.new(0, 0, 17, 35))
		@big = Animation.new(SDL::Surface.load("../assets/cactus_big.png"), SDL::Rect.new(0, 0, 25, 50))
		@big_ = Animation.new(SDL::Surface.load("../assets/cactus_big_.png"), SDL::Rect.new(0, 0, 75, 50)) 
		@type = [nil, nil]
		@cactus = [SDL::Rect.new(0, 0, 0, 0), SDL::Rect.new(0, 0, 0, 0)]
		@pos = [SDL::Vec2.new(600, 0), SDL::Vec2.new(700, 0)]
	end

	def gen(i)
		@type[i] = rand(0..2) # 0 : small, 1 : big, 2 : big_ 
		size = rand(1..3) # for number of cactus

		case @type[i]
		when 0
			if size < 3
				@cactus[i] = SDL::Rect.new(0, 0, size * @small.rect.w, 35)
			else
				x = [0, 3][rand(0..1)] * @small.rect.w
				@cactus[i] = SDL::Rect.new(x, 0, size * @small.rect.w, 35)
			end
			@pos[i].y = (@window.h - @small.rect.h) - 5
		when 1
			@cactus[i] = SDL::Rect.new(0, 0, size * @big.rect.w, 50)
			@pos[i].y = (@window.h - @big.rect.h) - 5
		when 2 
			@cactus[i] = SDL::Rect.new(0, 0, @big_.rect.w, 50) 			
			@pos[i].y = (@window.h - @big_.rect.h) - 5
		end
	end

	def move(i, xvel)
		@pos[i].x -= xvel
	end

	def draw(xvel)
		gen(0) if @pos[0].x >= @window.w
		gen(1) if @pos[1].x >= @window.w

		# the first cactus group 
		case @type[0]
		when 0
			SDL::Surface.blit(@small.tex, @cactus[0].x, @cactus[0].y,@cactus[0].w, @cactus[0].h, @window, @pos[0].x, @pos[0].y)			
		when 1
			SDL::Surface.blit(@big.tex, @cactus[0].x, @cactus[0].y,@cactus[0].w, @cactus[0].h, @window, @pos[0].x, @pos[0].y)			
		when 2
			SDL::Surface.blit(@big_.tex, @cactus[0].x, @cactus[0].y,@cactus[0].w, @cactus[0].h, @window, @pos[0].x, @pos[0].y)			
		end

		move(0, xvel) if (@pos[1].x <= 200 && @pos[0].x > @pos[1].x) || (@pos[1].x >= 200 && @pos[0].x < @pos[1].x)
		# the second cactus group
		if (@pos[0].x <= 200 && @pos[1].x > @pos[0].x) || (@pos[0].x >= 200 && @pos[0].x > @pos[1].x)
			#@pos[1].x = @pos[0].x + 200 if @pos[0].x == 200
			case @type[1]
			when 0
				SDL::Surface.blit(@small.tex, @cactus[1].x, @cactus[1].y,@cactus[1].w, @cactus[1].h, @window, @pos[1].x, @pos[1].y)			
			when 1
				SDL::Surface.blit(@big.tex, @cactus[1].x, @cactus[1].y,@cactus[1].w, @cactus[1].h, @window, @pos[1].x, @pos[1].y)			
			when 2
				SDL::Surface.blit(@big_.tex, @cactus[1].x, @cactus[1].y,@cactus[1].w, @cactus[1].h, @window, @pos[1].x, @pos[1].y)			
			end

			move(1, xvel)
		end
			
		@pos[0].x = @window.w if @pos[0].x <= -(@cactus[0].w) + -10
		@pos[1].x = @window.w if @pos[1].x <= -(@cactus[1].w) + -10 
 	end
end