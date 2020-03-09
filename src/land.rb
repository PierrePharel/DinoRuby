#!/usr/bin/env ruby -wKU
# encoding: UTF-8

$LOAD_PATH << '.'
require "sdl"
require "common.rb"

class Land
	def initialize
		@window = SDL::Screen.get
		@sprite = SDL::Surface.load("../assets/land.png")
		@speed = 6
		@x = [0, 0]
		@frame = SDL::Rect.new(0, 0, 600, 14)
		@y = (@window.h - @sprite.h) - 10
	end

	def animation
		SDL::Surface.blit(@sprite, 0, 0, @frame.w, @frame.h, @window, @x[0], @y)
		SDL::Surface.blit(@sprite, 600, 0, @frame.w, @frame.h, @window, @x[1], @y)
		@x[0] -= @speed
		if @x[0] <= 0
			@x[1] = @x[0] + @frame.w
		else
			@x[1] -= @speed
		end

		if @x[1] <= 0
			@x[0] = @x[1] + @frame.w
		end
	end

	def draw
		animation
	end
end