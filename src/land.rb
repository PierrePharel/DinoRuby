#!/usr/bin/env ruby -wKU
# encoding: UTF-8

$LOAD_PATH << '.'
require "sdl"
require "common.rb"
require "animation.rb"

class Land < Objekt
	attr_accessor :cactus

	def initialize
		super
		@tex = SDL::Texture.new(SDL::Surface.load("../assets/land.png"), SDL::Rect.new(0, 0, 600, 14))
		@xvel = 6
		@x = [0, 0]
		@pos = SDL::Vec2.new(0, (@window.h - @tex.rect.h) - 10)
		@cactus = Cactus.new
	end

	def draw(can_draw, can_move)
		# land 
		animation
		move
		# cactus
		@cactus.draw(@xvel, can_move) #if !can_draw
	end

	private
	def move
		if @x[0] <= 0
			@x[0] -= @xvel
			@x[1] = @x[0] + @tex.rect.w
		else
			@x[1] -= @xvel
		end

		if @x[1] <= 0
			@x[0] = @x[1] + @tex.rect.w
		end
	end

	def animation
		@tex.rect.x = [0, 600][rand(0..1)] if @x[0] >= @window.w
		SDL::Surface.blit(@tex.img, @tex.rect.x, 0, @tex.rect.w, @tex.rect.h, @window, @x[0], @pos.y)
		SDL::Surface.blit(@tex.img, @tex.rect.w, 0, @tex.rect.w, @tex.rect.h, @window, @x[1], @pos.y)
	end
end

class Cactus < Objekt
	attr_reader :pos

	def initialize
		super
		@small = SDL::Texture.new(SDL::Surface.load("../assets/cactus_small.png"), SDL::Rect.new(0, 0, 17, 35))
		@big = SDL::Texture.new(SDL::Surface.load("../assets/cactus_big.png"), SDL::Rect.new(0, 0, 25, 50))
		@big_ = SDL::Texture.new(SDL::Surface.load("../assets/cactus_big_.png"), SDL::Rect.new(0, 0, 76, 50)) 
		@type = [nil, nil]
		@cactus = [nil, nil]
		@pos = [SDL::Vec2.new(600, 0), SDL::Vec2.new(700, 0)]
	end

	def draw(xvel, can_move)
		gen(0) if @pos[0].x >= @window.w
		gen(1) if @pos[1].x >= @window.w

		# the first cactus group 
		if (@pos[1].x <= 200 && @pos[0].x > @pos[1].x) || (@pos[1].x >= 200 && @pos[0].x < @pos[1].x) || @pos[0].x == 600
			SDL::Surface.blit(@type[0].img, @cactus[0].x, @cactus[0].y, @cactus[0].w, @cactus[0].h, @window, @pos[0].x, @pos[0].y)
			move(0, xvel)
		end

		# the second cactus group
		if (@pos[0].x <= 200 && @pos[1].x > @pos[0].x) || (@pos[0].x >= 200 && @pos[0].x > @pos[1].x) || @pos[1].x == 600
			SDL::Surface.blit(@type[1].img, @cactus[1].x, @cactus[1].y, @cactus[1].w, @cactus[1].h, @window, @pos[1].x, @pos[1].y)
			move(1, xvel)
		end
			
		@pos[0].x = 600 if @pos[0].x <= -(@cactus[0].w)
		@pos[1].x = 600 if @pos[1].x <= -(@cactus[1].w)
 	end

 	def collision_box
 		boxes = []

 		boxes.push(SDL::Box.new(@pos[0].x, @pos[0].x + @cactus[0].w, @pos[0].y, @pos[0].y + @cactus[0].h)) #if @pos[0].x < @window.w && @pos[0].x >= 0
 		boxes.push(SDL::Box.new(@pos[1].x, @pos[1].x + @cactus[1].w, @pos[1].y, @pos[1].y + @cactus[1].h)) #if @pos[1].x < @window.w && @pos[1].x >= 0
 		
 		return boxes
 	end

 	def get_pos
 		return @pos
 	end

 	private
 	def move(i, xvel)
		@pos[i].x -= xvel
	end

	def gen(i)
		@type[i] = [@small, @big, @big_][rand(0..2)] # 0 : small, 1 : big, 2 : big_ 
		size = rand(1..3) # for number of cactus

		case @type[i]
		when @small
			if size < 3
				@cactus[i] = SDL::Rect.new(0, 0, size * @type[i].rect.w, 35)
			else
				x = [0, 3][rand(0..1)] * @type[i].rect.w
				@cactus[i] = SDL::Rect.new(x, 0, size * @type[i].rect.w, 35)
			end
			@pos[i].y = (@window.h - @type[i].rect.h) - 10
		when @big
			@cactus[i] = SDL::Rect.new(0, 0, size * @type[i].rect.w, 50)
			@pos[i].y = (@window.h - @type[i].rect.h) - 10 
		when @big_
			@cactus[i] = SDL::Rect.new(0, 0, @type[i].rect.w, 50)
			@pos[i].y = (@window.h - @type[i].rect.h) - 10
		end
	end
end