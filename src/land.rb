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
		@cactus = [Cactus.new, Cactus.new]
		@old_score = 0
	end

	def draw(score, draw_ptero)
		# land 
		animation
		move
		# cactus
		@old_score = score if score % 100 == 0
		if !draw_ptero
			if @cactus[1].pos.x <= 300 || @cactus[1].pos.x > @cactus[0].pos.x || @cactus[1].pos.x >= @window.w || score >= 100
				@cactus[0].draw(@xvel)
			end

			if !(score > 450 && @cactus[1].pos.x >= 600)
				if (@cactus[0].pos.x <= 300 || @cactus[0].pos.x > @cactus[1].pos.x)
					@cactus[1].draw(@xvel)
				end
			end
		end
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
	attr_reader :pos, :rect

	def initialize
		super
		@tex = [SDL::Texture.new(SDL::Surface.load("../assets/cactus_small.png"), SDL::Rect.new(0, 0, 17, 35)),
				SDL::Texture.new(SDL::Surface.load("../assets/cactus_big.png"), SDL::Rect.new(0, 0, 25, 50)),
				SDL::Texture.new(SDL::Surface.load("../assets/cactus_big_four.png"), SDL::Rect.new(0, 0, 76, 50))]
		@current_tex = nil
		@rect = nil
		@pos = SDL::Vec2.new(600, 0)
	end

	def draw(xvel)
		gen if @pos.x >= @window.w
		SDL::Surface.blit(@current_tex.img, @rect.x, @rect.y, @rect.w, @rect.h, @window, @pos.x, @pos.y)
		move(xvel)
		@pos.x = 600 if @pos.x <= -(@rect.w)
	end

	private
	def move(xvel)
		@pos.x -= xvel
	end

	def gen
		@current_tex = @tex[rand(0..2)] # 0 : small, 1 : big, 2 : big_ 
		size = rand(1..3) # for number of cactus

		case @current_tex
		when @tex[0]
			if size < 3
				@rect = SDL::Rect.new(0, 0, size * @current_tex.rect.w, 35)
			else
				x = [0, 3][rand(0..1)] * @current_tex.rect.w
				@rect = SDL::Rect.new(x, 0, size * @current_tex.rect.w, 35)
			end
			@pos.y = (@window.h - @current_tex.rect.h) - 10
		when @tex[1]
			@rect = SDL::Rect.new(0, 0, size * @current_tex.rect.w, 50)
			@pos.y = (@window.h - @current_tex.rect.h) - 10 
		when @tex[2]
			@rect = SDL::Rect.new(0, 0, @current_tex.rect.w, 50)
			@pos.y = (@window.h - @current_tex.rect.h) - 10
		end
	end
end